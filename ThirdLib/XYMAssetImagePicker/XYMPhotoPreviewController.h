

#import <UIKit/UIKit.h>

@interface XYMPhotoPreviewController : UIViewController
@property (nonatomic, strong) NSArray *photoArr;                // 所有图片的数组
@property (nonatomic, strong) NSMutableArray *selectedPhotoArr; // 当前选中的图片数组
@property (nonatomic, assign) NSInteger currentIndex;           // 用户点击的图片的索引
@property (nonatomic, assign) BOOL isSelectOriginalPhoto;       // 是否返回原图

// 返回最新的选中图片数组
@property (nonatomic, copy) void (^returnNewSelectedPhotoArrBlock)(NSMutableArray *newSeletedPhotoArr, BOOL isSelectOriginalPhoto);
@property (nonatomic, copy) void (^okButtonClickBlock)(NSMutableArray *newSeletedPhotoArr, BOOL isSelectOriginalPhoto);


@end
