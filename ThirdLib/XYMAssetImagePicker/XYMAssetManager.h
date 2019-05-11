
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

@class XYMAsset,XYMAlbum;

@interface XYMAssetManager : NSObject

@property (nonatomic, strong) PHCachingImageManager *cachingImageManager;

+ (instancetype)manager;

@property (nonatomic, assign) BOOL shouldFixOrientation;

// 如果得到了授权, 返回YES
- (BOOL)authorizationStatusAuthorized;

// 获得相册/相册数组
- (void)getCameraRollAlbum:(BOOL)allowPickingVideo completion:(void (^)(XYMAlbum *model))completion;
- (void)getAllAlbums:(BOOL)allowPickingVideo completion:(void (^)(NSArray<XYMAlbum *> *models))completion;

// 获得Asset/Asset数组
- (void)getAssetFromFetchResult:(id)result atIndex:(NSInteger)index allowPickingVideo:(BOOL)allowPickingVideo completion:(void (^)(XYMAsset *model))completion;
- (void)getAssetsFromFetchResult:(id)result allowPickingVideo:(BOOL)allowPickingVideo completion:(void (^)(NSArray<XYMAsset *> *models))completion;

// Get photo 获得照片
- (void)getPostImageWithAlbumModel:(XYMAsset *)model completion:(void (^)(UIImage *postImage))completion;
- (void)getPhotoWithAsset:(id)asset completion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isDegraded))completion;
- (void)getPhotoWithAsset:(id)asset photoWidth:(CGFloat)photoWidth completion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isDegraded))completion;

// 获取原图
- (void)getOriginalPhotoWithAsset:(id)asset completion:(void (^)(UIImage *photo,NSDictionary *info))completion;
- (UIImage *)getOriginalPhotoWithAsset:(id)asset;
- (NSData *)getOriginalPhotoDataWithAsset:(id)asset;
// 预览图
- (void)getPriviewPhotoWithAsset:(id)asset completion:(void (^)(UIImage *photo,NSDictionary *info))completion;
- (UIImage *)getPriviewPhotoWithAsset:(id)asset;
//获取Asset信息
- (void)getAssetInfoWithAsset:(id)asset completion:(void (^)(NSDictionary *info))completion;
- (NSDictionary *)getAssetInfoWithAsset:(id)asset;
// 获取缩略图
- (void)getThumbnailPhotoWithAsset:(id)asset completion:(void (^)(UIImage *photo,NSDictionary *info))completion;

// Get video 获得视频
- (void)getVideoWithAsset:(id)asset completion:(void (^)(AVPlayerItem * playerItem, NSDictionary * info))completion;

// Get photo bytes 获得一组照片的大小
- (void)getPhotosBytesWithArray:(NSArray *)photos completion:(void (^)(NSString *totalBytes))completion;
- (UIImage *)fixOrientation:(UIImage *)aImage;
@end
