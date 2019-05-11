

#import "XYMAssetCell.h"
#import "XYMAsset.h"
#import "XYMAssetManager.h"
#import "XYMAssetConstants.h"
#import "UIView+XYMExtension.h"
#import "XYMUIKit.h"

@interface XYMAssetCell ()
@property (strong, nonatomic)  UIImageView *imageView;
@property (strong, nonatomic)  UIImageView *selectImageView;
@property (strong, nonatomic)  UIView *bottomView;
@property (strong, nonatomic)  UIImageView *videoImageView;
@property (strong, nonatomic)  UILabel *timeLength;

@end
@implementation XYMAssetCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubViews];
    }
    return self;
}

- (void)configSubViews {
    self.clipsToBounds = YES;
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.xym_view_size = self.xym_view_size;

    [self addSubview:self.imageView];

    
    CGFloat cellWidth = self.xym_view_width;
    CGFloat cellHeight = self.xym_view_height;
    
    self.selectImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.selectImageView.userInteractionEnabled = YES;
    self.selectImageView.xym_view_size  = CGSizeMake(27, 27);
    self.selectImageView.xym_view_right = cellWidth;
    [self addSubview:self.selectImageView];

    self.selectPhotoButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.selectPhotoButton.tintColor = [UIColor clearColor];

    self.selectPhotoButton.frame = CGRectMake(cellWidth/2.0, 0, cellWidth/2.0, cellHeight/2.0);
    [self.selectPhotoButton addTarget:self action:@selector(selectPhotoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.selectPhotoButton];
    
    
    self.bottomView = [[UIView alloc]initWithFrame:CGRectZero];
    self.bottomView.xym_view_bottom = cellHeight;
    self.bottomView.xym_view_size = CGSizeMake(cellWidth, 17.0);
    [self addSubview:self.bottomView];

    
    self.videoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 0, 17, 17)];
//    [self.bottomView addSubview:self.videoImageView];
    
    self.timeLength = [[UILabel alloc]initWithFrame:CGRectZero];
    self.timeLength.xym_view_right = cellWidth -3.0f;
    self.timeLength.xym_view_size = CGSizeMake(49, 17);
    self.timeLength.font = [UIFont boldSystemFontOfSize:11];
//    [self.bottomView addSubview:self.timeLength];
}

- (void)setModel:(XYMAsset *)model {
    _model = model;
    [[XYMAssetManager manager] getPhotoWithAsset:model.asset photoWidth:self.xym_view_width completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
        self.imageView.image = photo;
        model.previewImage = photo;
    }];
    self.selectPhotoButton.selected = model.isSelected;
    //photo_def_photoPickerVc
    self.selectImageView.image = self.selectPhotoButton.isSelected ? [XYMUIKit imageName:@"photo_sel_photoPickerVc" ofBundle:@"Mobile.bundle"] : [XYMUIKit imageName:@"photo_def_photoPickerVc" ofBundle:@"Mobile.bundle"];
    self.type = XYMAssetCellTypePhoto;
    if (model.type == XYMAssetMediaTypeLivePhoto)      self.type = XYMAssetCellTypeLivePhoto;
    else if (model.type == XYMAssetMediaTypeAudio)     self.type = XYMAssetCellTypeAudio;
    else if (model.type == XYMAssetMediaTypeVideo) {
        self.type = XYMAssetCellTypeVideo;
        self.timeLength.text = model.timeLength;
    }
}

- (void)setType:(XYMAssetCellType)type {
    _type = type;
    if (type == XYMAssetCellTypePhoto || type == XYMAssetCellTypeLivePhoto) {
        _selectImageView.hidden = NO;
        _selectPhotoButton.hidden = NO;
        _bottomView.hidden = YES;
    } else {
        _selectImageView.hidden = YES;
        _selectPhotoButton.hidden = YES;
        _bottomView.hidden = NO;
    }
}

- (void)selectPhotoButtonClick:(UIButton *)sender {
    if (self.didSelectPhotoBlock) {
        self.didSelectPhotoBlock(sender.isSelected);
    }
    // photo_def_photoPickerVc
    self.selectImageView.image = sender.isSelected ? [XYMUIKit imageName:@"photo_sel_photoPickerVc" ofBundle:@"Mobile.bundle"] : [XYMUIKit imageName:@"photo_def_photoPickerVc" ofBundle:@"Mobile.bundle"];
    if (sender.isSelected) {
        [UIView showOscillatoryAnimationWithLayer:_selectImageView.layer type:WIMOscillatoryAnimationToBigger];
    }
}

@end


@interface XYMAlbumCell ()
@property (weak, nonatomic)  UIImageView *posterImageView;
@property (weak, nonatomic)  UILabel *titleLable;
@end

@implementation XYMAlbumCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubViews];
    }
    return self;
}

- (void)configSubViews {

//    self.imageView.layer.cornerRadius = 4.0f;
//    self.imageView.layer.masksToBounds = YES;
    self.imageView.clipsToBounds = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}


- (void)setModel:(XYMAlbum *)model {
    _model = model;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5.0f;

    NSMutableAttributedString *nameString = [[NSMutableAttributedString alloc] initWithString:model.name attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor blackColor],NSParagraphStyleAttributeName : paragraphStyle}];
    NSAttributedString *countString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%zd",model.count] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor blackColor]}];
    [nameString appendAttributedString:countString];

    self.textLabel.attributedText = nameString;
    
    [[XYMAssetManager manager] getPostImageWithAlbumModel:(id)model completion:^(UIImage *postImage) {
        self.imageView.image = postImage;
    }];

    //FIXME:  setNeedsLayout?
    [self layoutIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.clipsToBounds = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.frame = CGRectMake(10,10,70,70);
    
    self.textLabel.xym_view_left = self.imageView.xym_view_right + 15.0;
    CGFloat width = [UIScreen mainScreen].bounds.size.width - self.imageView.xym_view_width-15*3;
    self.textLabel.xym_view_size = CGSizeMake(width, 90);
    self.textLabel.numberOfLines = 2;
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)layoutSublayersOfLayer:(CALayer *)layer {
    [super layoutSublayersOfLayer:layer];
}

@end
