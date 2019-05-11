

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XYMAssetCellType) {
    XYMAssetCellTypePhoto = 0,
    XYMAssetCellTypeLivePhoto,
    XYMAssetCellTypeVideo,
    XYMAssetCellTypeAudio
};

@class XYMAsset;

@interface XYMAssetCell : UICollectionViewCell

@property (strong, nonatomic)   UIButton *selectPhotoButton;
@property (nonatomic, strong) XYMAsset *model;
@property (nonatomic, copy)   void (^didSelectPhotoBlock)(BOOL);
@property (nonatomic, assign) XYMAssetCellType type;

@end


@class XYMAlbum;

@interface XYMAlbumCell : UITableViewCell

@property (nonatomic, strong) XYMAlbum *model;

@end
