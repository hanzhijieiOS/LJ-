

#import "XYMPhotoPreviewController.h"
#import "XYMAsset.h"
#import "XYMPhotoPreviewCell.h"
#import "UIView+XYMExtension.h"
#import "XYMAssetPickerController.h"
#import "XYMAssetManager.h"
#import "XYMAssetConstants.h"
#import "XYMUIKit.h"

@interface XYMPhotoPreviewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate> {
    UICollectionView *_collectionView;
    BOOL _isHideNaviBar;
    
    UIView *_naviBar;
    UIButton *_backButton;
    UIButton *_selectButton;
    
    UIView *_toolBar;
    UIButton *_okButton;
    UIImageView *_numberImageView;
    UILabel *_numberLable;
    UIButton *_originalPhotoButton;
    UILabel *_originalPhotoLable;
}

@end
@implementation XYMPhotoPreviewController
- (NSMutableArray *)selectedPhotoArr {
    if (_selectedPhotoArr == nil) _selectedPhotoArr = [[NSMutableArray alloc] init];
    return _selectedPhotoArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configCollectionView];
    [self configCustomNaviBar];
    [self configBottomToolBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    if (iOS7Later) [UIApplication sharedApplication].statusBarHidden = YES;
    if (_currentIndex) [_collectionView setContentOffset:CGPointMake((self.view.xym_view_width) * _currentIndex, 0) animated:NO];
    [self refreshNaviBarAndBottomBarState];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    if (iOS7Later) [UIApplication sharedApplication].statusBarHidden = NO;
}

- (void)configCustomNaviBar {
    _naviBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.xym_view_width, 64)];
    _naviBar.backgroundColor = [UIColor colorWithRed:(34/255.0) green:(34/255.0)  blue:(34/255.0) alpha:1.0];
    _naviBar.alpha = 0.7;
    
    _backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 44, 44)];
    [_backButton setImage:[XYMUIKit imageName:@"navi_back" ofBundle:@"Mobile.bundle"] forState:UIControlStateNormal];
    [_backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    _selectButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.xym_view_width - 54, 10, 42, 42)];
    [_selectButton setImage:[XYMUIKit imageName:@"photo_def_photoPickerVc" ofBundle:@"Mobile.bundle"] forState:UIControlStateNormal];
    [_selectButton setImage:[XYMUIKit imageName:@"photo_sel_photoPickerVc" ofBundle:@"Mobile.bundle"] forState:UIControlStateSelected];
    [_selectButton addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    
    [_naviBar addSubview:_selectButton];
    [_naviBar addSubview:_backButton];
    [self.view addSubview:_naviBar];
}

- (void)configBottomToolBar {
    _toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.xym_view_height - 44, self.view.xym_view_width, 44)];
    CGFloat rgb = 34 / 255.0;
    _toolBar.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
    _toolBar.alpha = 0.7;
    
    XYMAssetPickerController *imagePickerVc = (XYMAssetPickerController *)self.navigationController;
    if (imagePickerVc.allowPickingOriginalPhoto) {
        _originalPhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _originalPhotoButton.frame = CGRectMake(5, 0, 120, 44);
        _originalPhotoButton.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
        _originalPhotoButton.contentEdgeInsets = UIEdgeInsetsMake(0, -50, 0, 0);
        _originalPhotoButton.backgroundColor = [UIColor clearColor];
        [_originalPhotoButton addTarget:self action:@selector(originalPhotoButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _originalPhotoButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_originalPhotoButton setTitle:@"原图" forState:UIControlStateNormal];
        [_originalPhotoButton setTitle:@"原图" forState:UIControlStateSelected];
        [_originalPhotoButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_originalPhotoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_originalPhotoButton setImage:[XYMUIKit imageName:@"preview_original_def" ofBundle:@"Mobile.bundle"] forState:UIControlStateNormal];
        [_originalPhotoButton setImage:[XYMUIKit imageName:@"photo_original_sel" ofBundle:@"Mobile.bundle"] forState:UIControlStateSelected];
        
        _originalPhotoLable = [[UILabel alloc] init];
        _originalPhotoLable.frame = CGRectMake(60, 0, 70, 44);
        _originalPhotoLable.textAlignment = NSTextAlignmentLeft;
        _originalPhotoLable.font = [UIFont systemFontOfSize:13];
        _originalPhotoLable.textColor = [UIColor whiteColor];
        _originalPhotoLable.backgroundColor = [UIColor clearColor];
        if (_isSelectOriginalPhoto) [self showPhotoBytes];
    }
    
    _okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _okButton.frame = CGRectMake(self.view.xym_view_width - 44 - 12, 0, 44, 44);
    _okButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_okButton addTarget:self action:@selector(okButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_okButton setTitle:@"发送" forState:UIControlStateNormal];
    [_okButton setTitleColor:imagePickerVc.oKButtonTitleColorNormal forState:UIControlStateNormal];
    
    _numberImageView = [[UIImageView alloc] initWithImage:[XYMUIKit imageName:@"photo_number_icon" ofBundle:@"Mobile.bundle"]];
    _numberImageView.backgroundColor = [UIColor clearColor];
    _numberImageView.frame = CGRectMake(self.view.xym_view_width - 56 - 24, 9, 26, 26);
    _numberImageView.hidden = _selectedPhotoArr.count <= 0;
    
    _numberLable = [[UILabel alloc] init];
    _numberLable.frame = _numberImageView.frame;
    _numberLable.font = [UIFont systemFontOfSize:16];
    _numberLable.textColor = [UIColor whiteColor];
    _numberLable.textAlignment = NSTextAlignmentCenter;
    _numberLable.text = [NSString stringWithFormat:@"%zd",_selectedPhotoArr.count];
    _numberLable.hidden = _selectedPhotoArr.count <= 0;
    _numberLable.backgroundColor = [UIColor clearColor];
    
    [_originalPhotoButton addSubview:_originalPhotoLable];
    [_toolBar addSubview:_okButton];
    [_toolBar addSubview:_originalPhotoButton];
    [_toolBar addSubview:_numberImageView];
    [_toolBar addSubview:_numberLable];
    [self.view addSubview:_toolBar];
}

- (void)configCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(self.view.xym_view_width, self.view.xym_view_height);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.xym_view_width , self.view.xym_view_height) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor blackColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.scrollsToTop = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.contentOffset = CGPointMake(0, 0);
    _collectionView.contentSize = CGSizeMake(self.view.xym_view_width * _photoArr.count, self.view.xym_view_height);
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[XYMPhotoPreviewCell class] forCellWithReuseIdentifier:@"XYMPhotoPreviewCell"];
}

#pragma mark - Click Event

- (void)select:(UIButton *)selectButton {
    XYMAsset *model = _photoArr[_currentIndex];
    if (!selectButton.isSelected) {
        // 选择照片,检查是否超过了最大个数的限制
        XYMAssetPickerController *imagePickerVc = (XYMAssetPickerController *)self.navigationController;
        if (self.selectedPhotoArr.count >= imagePickerVc.maxImagesCount) {
            [imagePickerVc showAlertWithTitle:[NSString stringWithFormat:@"你最多只能选择%zd张照片",imagePickerVc.maxImagesCount]];
            return;
            // 2. if not over the maxImagesCount / 如果没有超过最大个数限制
        } else {
            [self.selectedPhotoArr addObject:model];
            if (model.type == XYMAssetMediaTypeVideo) {
                XYMAssetPickerController *imagePickerVc = (XYMAssetPickerController *)self.navigationController;
                [imagePickerVc showAlertWithTitle:@"多选状态下选择视频，默认将视频当图片发送"];
            }
        }
    } else {
        [self.selectedPhotoArr removeObject:model];
    }
    model.isSelected = !selectButton.isSelected;
    [self refreshNaviBarAndBottomBarState];
    if (model.isSelected) {
        [UIView showOscillatoryAnimationWithLayer:selectButton.imageView.layer type:WIMOscillatoryAnimationToBigger];
    }
    [UIView showOscillatoryAnimationWithLayer:_numberImageView.layer type:WIMOscillatoryAnimationToSmaller];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
    if (self.returnNewSelectedPhotoArrBlock) {
        self.returnNewSelectedPhotoArrBlock(self.selectedPhotoArr,_isSelectOriginalPhoto);
    }
}

- (void)okButtonClick {
    if (_selectedPhotoArr.count == 0) {
        XYMAsset *model = _photoArr[_currentIndex];
        [_selectedPhotoArr addObject:model];
    }
    if (self.okButtonClickBlock) {
        self.okButtonClickBlock(self.selectedPhotoArr,_isSelectOriginalPhoto);
    }
}

- (void)originalPhotoButtonClick {
    _originalPhotoButton.selected = !_originalPhotoButton.isSelected;
    _isSelectOriginalPhoto = _originalPhotoButton.isSelected;
    _originalPhotoLable.hidden = !_originalPhotoButton.isSelected;
    if (_isSelectOriginalPhoto) {
        [self showPhotoBytes];
        if (!_selectButton.isSelected) [self select:_selectButton];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offSet = scrollView.contentOffset;
    _currentIndex = offSet.x / self.view.xym_view_width;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self refreshNaviBarAndBottomBarState];
}

#pragma mark - UICollectionViewDataSource && Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _photoArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XYMPhotoPreviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XYMPhotoPreviewCell" forIndexPath:indexPath];
    cell.model = _photoArr[indexPath.row];
    
    __block BOOL _weakIsHideNaviBar = _isHideNaviBar;
    __weak typeof(_naviBar) weakNaviBar = _naviBar;
    __weak typeof(_toolBar) weakToolBar = _toolBar;
    if (!cell.singleTapGestureBlock) {
        cell.singleTapGestureBlock = ^(){
            // show or hide naviBar / 显示或隐藏导航栏
            _weakIsHideNaviBar = !_weakIsHideNaviBar;
            weakNaviBar.hidden = _weakIsHideNaviBar;
            weakToolBar.hidden = _weakIsHideNaviBar;
        };
    }
    return cell;
}

#pragma mark - Private Method

- (void)refreshNaviBarAndBottomBarState {
    XYMAsset *model = _photoArr[_currentIndex];
    _selectButton.selected = model.isSelected;
    _numberLable.text = [NSString stringWithFormat:@"%zd",_selectedPhotoArr.count];
    _numberImageView.hidden = (_selectedPhotoArr.count <= 0 || _isHideNaviBar);
    _numberLable.hidden = (_selectedPhotoArr.count <= 0 || _isHideNaviBar);
    
    _originalPhotoButton.selected = _isSelectOriginalPhoto;
    _originalPhotoLable.hidden = !_originalPhotoButton.isSelected;
    if (_isSelectOriginalPhoto) [self showPhotoBytes];
    
    // If is previewing video, hide original photo button
    // 如果正在预览的是视频，隐藏原图按钮
    if (_isHideNaviBar) return;
    if (model.type == XYMAssetMediaTypeVideo) {
        _originalPhotoButton.hidden = YES;
        _originalPhotoLable.hidden = YES;
    } else {
        _originalPhotoButton.hidden = NO;
        if (_isSelectOriginalPhoto)  _originalPhotoLable.hidden = NO;
    }
}

- (void)showPhotoBytes {
    [[XYMAssetManager manager] getPhotosBytesWithArray:@[_photoArr[_currentIndex]] completion:^(NSString *totalBytes) {
        _originalPhotoLable.text = [NSString stringWithFormat:@"(%@)",totalBytes];
    }];
}
@end
