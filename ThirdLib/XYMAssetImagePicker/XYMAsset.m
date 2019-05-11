

#import "XYMAsset.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "XYMAssetConstants.h"
@implementation XYMAsset

+ (instancetype)modelWithAsset:(id)asset type:(XYMAssetMediaType)type{
    XYMAsset *model = [[XYMAsset alloc] init];
    model.asset = asset;
    model.isSelected = NO;
    model.type = type;
    return model;
}

+ (instancetype)modelWithAsset:(id)asset type:(XYMAssetMediaType)type timeLength:(NSString *)timeLength {
    XYMAsset *model = [self modelWithAsset:asset type:type];
    model.timeLength = timeLength;
    return model;
}

- (NSString *)assetIdentifier {
    if ([self.asset isKindOfClass:[ALAsset class]]) {
        ALAsset *temp = (ALAsset*)self.asset;
        ALAssetRepresentation *defaultRepresentation = [temp defaultRepresentation];
        NSString *uti = [defaultRepresentation UTI];
        NSURL *url = [[temp valueForProperty:ALAssetPropertyURLs] valueForKey:uti];
        return url.absoluteString;
    }
    
    if (iOS8Later && [self.asset isKindOfClass:[PHAsset class]]) {
        return [(PHAsset *)self.asset localIdentifier];
    }
    
    return nil;
}
@end


@implementation XYMAlbum

@end
