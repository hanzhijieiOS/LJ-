//
//  XYMDataCache.h
//  MobileApp
//
//  Created by dengtuotuo on 2017/11/8.
//  Copyright © 2017年 xiyoumobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYMError.h"
#import "XYMMediaConstants.h"

typedef NS_ENUM(NSInteger, XYMMediaCacheOptions){

    XYMMediaCacheOptionsNone = 0,           // 无缓存
    
    XYMMediaCacheOptionsMemory = 1 << 1,    // 内存缓存  内存缓存只适合Image  其他如果设置内存缓存，则不存储
    
    XYMMediaCacheOptionsDisk = 1 << 2,      // 磁盘缓存，当参数单独使用磁盘取，不自动保存内存缓存
    
    XYMMediaCacheOptionsDownload = 1 << 3,   // 从网络下载
    
    XYMMediaCacheOptionsAllCache = XYMMediaCacheOptionsMemory|XYMMediaCacheOptionsDisk,    // 内存、磁盘缓存
    
    XYMMediaCacheOptionsAll = XYMMediaCacheOptionsAllCache|XYMMediaCacheOptionsDownload    // 通常在优先缓存取数据，没有数据则下载数据

};


/**
 异步获取数据回调

 @param data 数据
 @param error 获取数据错误
 @param option 取出数据的方式
 */
typedef void(^XYMDataFormCacheHandler) (NSObject<NSCoding> *data, XYMError *error,XYMMediaCacheOptions option);


/**
 异步存储数据

 @param path 如果是文件，则返回缓存路径
 @param error 是否存储失败
 */
typedef void(^XYMStoreDataCacheHandler) (NSString *path,XYMError *error);


@interface XYMDataCache : NSObject

+ (instancetype)sharedInstance;

/**
  根据关键字获取缓存路径 ！！！ 
  注意这里的路径是根据key与type构建的路径，
  路径有可能对应的有文件，也有可能没有，只是构建了一个路径

 @param key 关键字 如果关键字带有后缀，则构造出带有后缀的MD5文件缓存路径
 @param type 缓存的类型
 @return 构造缓存的路径
 */
- (NSString *)defaultCachePathForKey:(NSString * )key mediaCacheType:(XYMMediaType) type;


/**
 判断文件是否存在

 @param key 文件缓存关键字
 @param type 文件缓存类型
 @return 返回文件的路径，如果存在返回路径，否则nil
 */
- (NSString *)fileExistsForKey:(NSString *)key mediaCacheType:(XYMMediaType)type;


#pragma - mark sync get set

/**
 同步读取数据

 @param key 缓存的关键字
 @param type 缓存的类型
 @param option 缓存的路径
 @return 返回NSData nil 如果图片则为Image
 */
- (NSObject<NSCoding> *)dataFormCacheForKey:(NSString *)key
                             mediaCacheType:(XYMMediaType) type
                          mediaCacheOptions:(XYMMediaCacheOptions)option;


/**
 同步存储

 @param key 缓存的关键字
 @param data 存储的数据 图片则为Image
 @param type 缓存的类型
 @param option 缓存的路径
 @return 返回error，如果无错误就为nil
 */
- (XYMError *)store:(NSString *)key
              data:(NSObject<NSCoding> *) data
    mediaCacheType:(XYMMediaType)type
 mediaCacheOptions:(XYMMediaCacheOptions) option;

#pragma -mark async get set


/**
 异步存储数据

 @param key 缓存的关键字
 @param data 缓存的数据
 @param type 缓存类型
 @param option 缓存类型
 @param handler 缓存的结果处理
 */
- (void)store:(NSString *)key
         data:(NSObject<NSCoding>*)data
mediaCacheType:(XYMMediaType)type
mediaCacheOptions:(XYMMediaCacheOptions)option
 storeHandler:(XYMStoreDataCacheHandler)handler;


/**
 异步获取数据

 @param key 缓存的关键字
 @param type 缓存数据类型
 @param option 缓存类型
 @param handler 获取数据结果处理
 */
- (void)dataFormCacheForKey:(NSString *)key
             mediaCacheType:(XYMMediaType)type
          mediaCacheOptions:(XYMMediaCacheOptions)option
       dataFormCacheHandler:(XYMDataFormCacheHandler)handler;


/**
 存储文件

 @param filePath 原始文件路径
 @param key 缓存关键字key
 @param type 缓存文件类型
 @param option 缓存类型
 @return 错误结果
 */
- (XYMError *)storeFile:(NSString *)filePath
                 forKey:(NSString *)key
         mediaCacheType:(XYMMediaType)type
      mediaCacheOptions:(XYMMediaCacheOptions)option;


/**
 删除文件

 @param filePath 文件得路径
 @return 是否删除错误
 */
- (XYMError *)deleteFileIfExist:(NSString *)filePath;

- (NSUInteger)getSize;
- (NSUInteger)getDiskCount;
@end
