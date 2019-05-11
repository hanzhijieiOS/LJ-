//
//  XYMDataCache.m
//  MobileApp
//
//  Created by dengtuotuo on 2017/11/8.
//  Copyright © 2017年 xiyoumobile. All rights reserved.
//

#import "XYMDataCache.h"
#import "XYUtils.h"
#import <CommonCrypto/CommonDigest.h>

static NSUInteger const XYMMediaMemoryCacheSingleLimit = 1024 * 1024; // 1M
static NSInteger const XYMMediaMaxBindingCount   = 10000 ;
static NSInteger const XYMMediaBatchBindingCount = 100 ;


// See https://github.com/rs/SDWebImage/pull/1141 for discussion  修古iOS7 内存不足时候 NSCache crash
@interface XYMDataPurgeCache : NSCache


@end

@implementation XYMDataPurgeCache

- (nonnull instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeAllObjects) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}

@end


@interface XYMDataCache()
@property (nonatomic,strong) XYMDataPurgeCache *memCache;

@property (nonatomic,copy) NSString *imgCachePath;

@property (nonatomic,copy) NSString *videoCachePath;

@property (nonatomic,copy) NSString *pluginCachePath;

@property (nonatomic,copy) NSString *fileCachePath;

@property (nonatomic,copy) NSString *tmpCachePath;

@property (strong, nonatomic, nullable) dispatch_queue_t ioQueue;

@property(nonatomic, strong) NSFileManager *fileManager;
@end

static NSString *prevPath = @"com.xiyoumobile.cache";

@implementation XYMDataCache

#pragma -mark init

+ (instancetype)sharedInstance{
    
    static XYMDataCache *defaultInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultInstance = [[XYMDataCache alloc]init];
    });
    return defaultInstance;
}

- (instancetype)init{
    
    if(self = [super init]){
        
        //创建IO串行队列  操作文件读写
        _ioQueue = dispatch_queue_create("com.xiyoumobile.DataCache.ioSerialQueue", DISPATCH_QUEUE_SERIAL);
        _fileManager = [NSFileManager defaultManager];
        
        _imgCachePath = [self makeDiskCachePath:[prevPath stringByAppendingString:@"/imgs"]];
        _videoCachePath = [self makeDiskCachePath:[prevPath stringByAppendingString:@"/videos"]];
        _pluginCachePath = [self makeDiskCachePath:[prevPath stringByAppendingString:@"/plugins"]];
        _fileCachePath = [self makeDiskCachePath:[prevPath stringByAppendingString:@"/files"]];
        _tmpCachePath = [self makeDiskCachePath:[prevPath stringByAppendingString:@"/tmps"]];
        
        //创建文件夹
        if(![self.fileManager fileExistsAtPath:_imgCachePath]){
            
            [self.fileManager createDirectoryAtPath:_imgCachePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        if(![self.fileManager fileExistsAtPath:_videoCachePath]){
            
            [self.fileManager createDirectoryAtPath:_videoCachePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        if(![self.fileManager fileExistsAtPath:_pluginCachePath]){
            
            [self.fileManager createDirectoryAtPath:_pluginCachePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        if(![self.fileManager fileExistsAtPath:_fileCachePath]){
            
            [self.fileManager createDirectoryAtPath:_fileCachePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        if(![self.fileManager fileExistsAtPath:_tmpCachePath]){
            
            [self.fileManager createDirectoryAtPath:_tmpCachePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        //初始化内存缓存  内存缓存只用于图片缓存
        _memCache = [[XYMDataPurgeCache alloc]init];
        _memCache.name = _imgCachePath;
        
        
        //        // 触发清理缓存
        //        [[NSNotificationCenter defaultCenter] addObserver:self
        //                                                 selector:@selector(clearMemoryCache)
        //                                                     name:UIApplicationDidReceiveMemoryWarningNotification
        //                                                   object:nil];
        //
        //        [[NSNotificationCenter defaultCenter] addObserver:self
        //                                                 selector:@selector(clearExpiredCache)
        //                                                     name:UIApplicationWillTerminateNotification
        //                                                   object:nil];
        //
        //        [[NSNotificationCenter defaultCenter] addObserver:self
        //                                                 selector:@selector(backgroundDeleteOldFiles)
        //                                                     name:UIApplicationDidEnterBackgroundNotification
        //                                                   object:nil];
        //
    }
    return self;
}

#pragma -mark privateTools

- (nullable NSString *)getMD5ValueForKey:(nullable NSString *)key {
    const char *str = key.UTF8String;
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%@",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10],
                          r[11], r[12], r[13], r[14], r[15], [key.pathExtension isEqualToString:@""] ? @"" : [NSString stringWithFormat:@".%@", key.pathExtension]];
    
    return filename;
}

- (nullable NSString *)makeDiskCachePath:(nonnull NSString*)fullNamespace {
    NSArray<NSString *> *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths[0] stringByAppendingPathComponent:fullNamespace];
}


- (NSString *)defaultCachePathForKey:(NSString *)key mediaCacheType:(XYMMediaType)type{
    
    if([XYUtils isEmptyString:key]){
        
        return nil;
    }
    NSString *fileName = [self getMD5ValueForKey:key];
    NSString *filePath = [self filePathWithCacheType:type];
    if(filePath){
        
        filePath = [filePath stringByAppendingPathComponent:fileName];
    }
    return filePath;
}

- (NSString *)fileExistsForKey:(NSString *)key mediaCacheType:(XYMMediaType)type{
    
    NSString *filePath = [self defaultCachePathForKey:key mediaCacheType:type];
    
    if([_fileManager fileExistsAtPath:filePath]){
        
        return filePath;
    }
    return nil;
    
}

- (NSString *)filePathWithCacheType:(XYMMediaType)type{
    
    NSString *filePath = nil;
    
    switch (type) {
        case XYMMediaTypeImg:{
            
            filePath = _imgCachePath;
            break;
        }
            
        case XYMMediaTypePlugin:{
            
            filePath = _pluginCachePath;
            break;
        }
            
        case XYMMediaTypeTmp:{
            
            filePath = _tmpCachePath;
            break;
        }
            
        case XYMMediaTypeVideo:{
            
            filePath = _videoCachePath;
            break;
        }
        case XYMMediaTypeFile:{
            
            filePath = _fileCachePath;
            break;
        }
            
            
        default:
            break;
    }
    
    return filePath;
    
}

- (NSInteger)costForObj:(NSObject<NSCoding> *)obj {
    if ([obj isKindOfClass:[NSData class]]) {
        NSInteger cost = ((NSData *)obj).length;
        return cost;
    }
    
    if ([obj isKindOfClass:[UIImage class]]) {
        CGSize size = ((UIImage *)obj).size;
        NSInteger cost = size.height * size.width * 4;
        return cost;
    }
    
    return 0;
}
#pragma -mrak sync get set

- (NSObject<NSCoding>*)dataFormCacheForKey:(NSString *)key mediaCacheType:(XYMMediaType)type mediaCacheOptions:(XYMMediaCacheOptions)option{
    
    if([XYUtils isEmptyString:key]){
        
        return nil;
    }
    NSString *keyCopy = [key copy];
    NSData *data = nil;
    
    if(option & XYMMediaCacheOptionsMemory){
        
        data = [self.memCache objectForKey:[self getMD5ValueForKey:keyCopy]];
    }
    if(data){
        
        return data;
    }
    if(option & XYMMediaCacheOptionsDisk){
        
        NSString *filePath = [self fileExistsForKey:key mediaCacheType:type];
        if(filePath){
            NSError *error;
            //采用内存映射 data不直接加载到内存中，读写在磁盘
            data = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
            NSUInteger cost = data.length;
            // 内存缓存限制 1M  如果是图片，并且从内存中读取没有缓存，则将其缓存到内存中
            BOOL needCacheMemory = (option & XYMMediaCacheOptionsMemory) && (XYMMediaTypeImg & type) &&
            (cost < XYMMediaMemoryCacheSingleLimit);
            
            if(data){
                
                if(needCacheMemory){
                    
                    [self.memCache setObject:data forKey:[self getMD5ValueForKey:keyCopy] cost:cost];
                }
                return data;
            }
        }
    }
    return nil;
}

- (XYMError *)store:(NSString *)key data:(NSObject<NSCoding> *)data mediaCacheType:(XYMMediaType)type mediaCacheOptions:(XYMMediaCacheOptions)option{
    
    __block XYMError *errorInfo = nil;
    NSString *keyCopy = nil;
    //参数校验
    if([XYUtils isEmptyString:key]){
        
        errorInfo = [[XYMError alloc]initWithErrorCode:-1 msg:@"缓存关键字不能为空"];
        return errorInfo;
    }
    keyCopy = [key copy];
    if(!data){
        errorInfo = [[XYMError alloc]initWithErrorCode:-1 msg:@"缓存数据不能为空"];
        return errorInfo;
    }
    if((option & XYMMediaCacheOptionsMemory) && (type & XYMMediaTypeImg)){
        
        NSUInteger cost = [self costForObj:data];
        if(cost < XYMMediaMemoryCacheSingleLimit){
            [self.memCache setObject:data forKey:[self getMD5ValueForKey:keyCopy] cost:cost];
        }
    }
    //这里仅支持NSData对于音视频，解码后的图片之类的数据，请使用文件复制
    BOOL isData = [data isKindOfClass:[NSData class]];
    __weak typeof (self)wSelf = self;
    __block NSError *error;
    if(isData && (option & XYMMediaCacheOptionsDisk)){
        
        dispatch_sync(self.ioQueue, ^{
            
            NSString *dirPath = [wSelf filePathWithCacheType:type];
            //如果文件夹不存在，则直接创建文件夹
            if(![wSelf.fileManager fileExistsAtPath:dirPath]){
                
                [wSelf.fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error];
                if(error){
                    errorInfo = [[XYMError alloc]initWithErrorCode:-1 msg:@"创建文件目录失败"];
                    return ;
                }
            }
            
            //写入缓存路径
            NSString *cachePath = [wSelf fileExistsForKey:keyCopy mediaCacheType:type];
            if(cachePath){
                
                [wSelf.fileManager removeItemAtPath:cachePath error:&error];
                if(error){
                    errorInfo = [[XYMError alloc]initWithErrorCode:-1 msg:@"删除缓存文件失败"];
                    return ;
                }
            }else{
                
                //如果文件不存在构建缓存文件路径
                cachePath = [wSelf defaultCachePathForKey:keyCopy mediaCacheType:type];
                
            }
            
            BOOL result = [wSelf.fileManager createFileAtPath:cachePath contents:(NSData *)data attributes:nil];
            if(!result){
                errorInfo = [[XYMError alloc]initWithErrorCode:-1 msg:@"写入缓存文件失败"];
                return ;
            }
            
        });
    }
    return errorInfo;
}

#pragma -mark async get set
- (void)dataFormCacheForKey:(NSString *)key mediaCacheType:(XYMMediaType)type mediaCacheOptions:(XYMMediaCacheOptions)option dataFormCacheHandler:(XYMDataFormCacheHandler)handler{
    
    __block XYMError *errorInfo;
    if([XYUtils isEmptyString:key]){
        
        errorInfo = [[XYMError alloc]initWithErrorCode:-1 msg:@"缓存关键字不能为空"];
        if(handler){
            
            handler(nil,errorInfo,XYMMediaCacheOptionsNone);
        }
        return;
    }
    NSString *keyCopy = [key copy];
    __block NSData *data = nil;
    
    if(option & XYMMediaCacheOptionsMemory){
        
        data = [self.memCache objectForKey:[self getMD5ValueForKey:keyCopy]];
    }
    if(data){
        
        if(handler){
            
            handler(data,nil,XYMMediaCacheOptionsMemory);
        }
        return;
    }
    __weak typeof (self)wSelf = self;
    //取磁盘缓存
    if(option & XYMMediaCacheOptionsDisk){
        
        dispatch_async(self.ioQueue, ^{
            
            NSString *filePath = [wSelf fileExistsForKey:key mediaCacheType:type];
            if(filePath){
                NSError *error;
                //采用内存映射 data不直接加载到内存中，读写在磁盘
                data = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
                NSUInteger cost = data.length;
                // 内存缓存限制 1M  如果是图片，并且从内存中读取没有缓存，则将其缓存到内存中
                BOOL needCacheMemory = (option & XYMMediaCacheOptionsMemory) && (XYMMediaTypeImg & type) &&
                (cost < XYMMediaMemoryCacheSingleLimit);
                
                if(data){
                    
                    if(needCacheMemory){
                        
                        [self.memCache setObject:data forKey:[self getMD5ValueForKey:keyCopy] cost:cost];
                    }
                    //内存磁盘没有缓存
                    if(handler){
                        
                        handler(data,nil,XYMMediaCacheOptionsNone);
                    }
                    
                }else{
                    
                    //取缓存出错
                    if(handler){
                        errorInfo = [[XYMError alloc]initWithErrorCode:-1 msg:@"取磁盘缓存出错"];
                        handler(nil,errorInfo,XYMMediaCacheOptionsNone);
                    }
                }
            }else{
                //内存磁盘没有缓存
                if(handler){
                    
                    handler(nil,nil,XYMMediaCacheOptionsNone);
                }
            }
        });
    }else{
        
        //内存没有缓存，并且没有从磁盘取数据的回调
        if(handler){
            
            handler(nil,nil,XYMMediaCacheOptionsNone);
        }
    }
}

- (void)store:(NSString *)key data:(NSObject<NSCoding> *)data mediaCacheType:(XYMMediaType)type mediaCacheOptions:(XYMMediaCacheOptions)option storeHandler:(XYMStoreDataCacheHandler)handler{
    
    __block XYMError *errorInfo = nil;
    NSString *keyCopy = nil;
    //参数校验
    if([XYUtils isEmptyString:key]){
        
        errorInfo = [[XYMError alloc]initWithErrorCode:-1 msg:@"缓存关键字不能为空"];
        if(handler){
            
            handler(nil,errorInfo);
        }
        return ;
    }
    keyCopy = [key copy];
    if(!data){
        errorInfo = [[XYMError alloc]initWithErrorCode:-1 msg:@"缓存数据不能为空"];
        if(handler){
            
            handler(nil,errorInfo);
        }
        return ;
    }
    if((option & XYMMediaCacheOptionsMemory) && (type & XYMMediaTypeImg)){
        
        NSUInteger cost = [self costForObj:data];
        if(cost < XYMMediaMemoryCacheSingleLimit){
            [self.memCache setObject:data forKey:[self getMD5ValueForKey:keyCopy] cost:cost];
        }
    }
    
    if(option & XYMMediaCacheOptionsDisk){
        
        //这里仅支持NSData对于音视频，解码后的图片之类的数据，请使用文件复制
        BOOL isData = [data isKindOfClass:[NSData class]];
        __weak typeof (self)wSelf = self;
        __block NSError *error;
        if(isData && (option & XYMMediaCacheOptionsDisk)){
            
            dispatch_async(self.ioQueue, ^{
                
                
                NSString *dirPath = [wSelf filePathWithCacheType:type];
                //如果文件夹不存在，则直接创建文件夹
                if(![wSelf.fileManager fileExistsAtPath:dirPath]){
                    
                    [wSelf.fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error];
                    if(error){
                        errorInfo = [[XYMError alloc]initWithErrorCode:-1 msg:@"创建文件目录失败"];
                        if(handler){
                            
                            handler(nil,errorInfo);
                        }
                        return ;
                    }
                }
                
                //写入缓存路径
                NSString *cachePath = [wSelf fileExistsForKey:keyCopy mediaCacheType:type];
                if(cachePath){
                    
                    [wSelf.fileManager removeItemAtPath:cachePath error:&error];
                    if(error){
                        errorInfo = [[XYMError alloc]initWithErrorCode:-1 msg:@"删除缓存文件失败"];
                        if(handler){
                            
                            handler(nil,errorInfo);
                        }
                        return ;
                    }
                }else{
                    
                    //如果文件不存在构建缓存文件路径
                    cachePath = [wSelf defaultCachePathForKey:keyCopy mediaCacheType:type];
                    
                }
                
                BOOL result = [wSelf.fileManager createFileAtPath:cachePath contents:(NSData *)data attributes:nil];
                if(!result){
                    
                    errorInfo = [[XYMError alloc]initWithErrorCode:-1 msg:@"写入缓存文件失败"];
                    if(handler){
                        
                        handler(nil,errorInfo);
                    }
                    return ;
                }else{
                    //存储成功
                    if(handler){
                        
                        handler(cachePath,nil);
                    }
                    return ;
                }
                
            });
        }
    }else{
        
        //磁盘不缓存，内存缓存的回调
        if(handler){
            
            handler(nil,nil);
        }
    }
}

- (XYMError *)storeFile:(NSString *)filePath forKey:(NSString *)key mediaCacheType:(XYMMediaType)type mediaCacheOptions:(XYMMediaCacheOptions)option{
    
    XYMError *errorInfo = nil;
    NSError *error = nil;
    //参数校验
    if([XYUtils isEmptyString:filePath]){
        
        errorInfo = [[XYMError alloc]initWithErrorCode:-1 msg:@"原始文件路径不能为空"];
        return errorInfo;
    }
    if([XYUtils isEmptyString:key]){
        
        errorInfo = [[XYMError alloc]initWithErrorCode:-1 msg:@"缓存key不能为空"];
        return errorInfo;
    }
    if(option & XYMMediaCacheOptionsDisk){
        
        //判断原始文件是否存在
        if(![_fileManager fileExistsAtPath:filePath]){
            
            errorInfo = [[XYMError alloc]initWithErrorCode:-1 msg:@"待移动的文件不存在"];
            return errorInfo;
        }
        
        //先移除原有key对应的文件
        NSString *fileCopyPath = [self fileExistsForKey:key mediaCacheType:type];
        if(fileCopyPath){
            
            [_fileManager removeItemAtPath:fileCopyPath error:&error];
            if(error){
                
                errorInfo = [[XYMError alloc]initWithErrorCode:-1 msg:@"删除文件失败"];
            }
        }else{
            
            fileCopyPath = [self defaultCachePathForKey:key mediaCacheType:type];
        }
        //移动文件
        [_fileManager moveItemAtPath:filePath toPath:fileCopyPath error:&error];
        if(error){
            
            errorInfo = [[XYMError alloc]initWithErrorCode:-1 msg:@"移动文件失败"];
        }
        
    }
    
    return errorInfo;
}

- (XYMError *)deleteFileIfExist:(NSString *)filePath{
    
    XYMError *errorInfo = nil;
    NSError *error;
    if(![_fileManager fileExistsAtPath:filePath]){
        
        errorInfo = [[XYMError alloc]initWithErrorCode:-1 msg:@"待删除的文件不存在"];
    }else{
        
        [_fileManager removeItemAtPath:filePath error:&error];
        if(error){
            
            errorInfo = [XYMError errorWithSystemNSError:error];
        }
    }
    return errorInfo;
}

#pragma -mark Cache Info
- (NSUInteger)getSize {
    __block NSUInteger size = 0;
//    dispatch_sync(self.ioQueue, ^{
//        NSDirectoryEnumerator *fileEnumerator = [_fileManager enumeratorAtPath:[self makeDiskCachePath:prevPath]];
//        for (NSString *fileName in fileEnumerator) {
//            NSString *filePath = [[self makeDiskCachePath:prevPath] stringByAppendingPathComponent:fileName];
//            NSDictionary<NSString *, id> *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
//            size += [attrs fileSize];
//        }
//    });
    [_fileManager removeItemAtPath:[self makeDiskCachePath:prevPath] error:nil];
    return size;
}

- (NSUInteger)getDiskCount {
    __block NSUInteger count = 0;
    dispatch_sync(self.ioQueue, ^{
        NSDirectoryEnumerator *fileEnumerator = [_fileManager enumeratorAtPath:prevPath];
        count = fileEnumerator.allObjects.count;
    });
    return count;
}

@end
