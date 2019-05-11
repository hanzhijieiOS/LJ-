

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, XYMAssetMediaType) {
    XYMAssetMediaTypePhoto = 0,
    XYMAssetMediaTypeLivePhoto,
    XYMAssetMediaTypeVideo,
    XYMAssetMediaTypeAudio
};

@interface XYMAsset : NSObject

@property (nonatomic, strong) id asset;             // PHAsset or ALAsset
@property (nonatomic, assign) BOOL isSelected;      // default is No
@property (nonatomic, assign) XYMAssetMediaType type;
@property (nonatomic, copy)   NSString *timeLength;
@property (nonatomic, strong) UIImage *previewImage;
@property (nonatomic, assign) BOOL needCompress;

@property (nonatomic, copy)   NSString *assetIdentifier;     // 唯一标示符

/// 用一个PHAsset/ALAsset实例，初始化一个照片模型
+ (instancetype)modelWithAsset:(id)asset type:(XYMAssetMediaType)type;
+ (instancetype)modelWithAsset:(id)asset type:(XYMAssetMediaType)type timeLength:(NSString *)timeLength;


@end


@class PHFetchResult;
@interface XYMAlbum : NSObject

@property (nonatomic, strong) NSString *name;        // The album name
@property (nonatomic, assign) NSInteger count;       // Count of photos the album contain
@property (nonatomic, strong) id result;             // PHFetchResult<PHAsset> or ALAssetsGroup<ALAsset>

@end
