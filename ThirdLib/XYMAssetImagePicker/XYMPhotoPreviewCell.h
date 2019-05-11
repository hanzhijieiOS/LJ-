

#import <UIKit/UIKit.h>

@class XYMAsset;

@interface XYMPhotoPreviewCell : UICollectionViewCell
@property (nonatomic, strong) XYMAsset *model;
@property (nonatomic, copy) void (^singleTapGestureBlock)();

@end
