
#import "XYMPhotoPickerController.h"
#import "XYMAssetPickerController.h"
#import "XYMPhotoPreviewController.h"
#import "XYMAsset.h"
#import "XYMAssetCell.h"
#import "UIView+XYMExtension.h"
#import "XYMAssetManager.h"
#import "XYMVideoPlayerController.h"
#import "XYMUIKit.h"
#import "XYMAssetConstants.h"


@interface XYMPhotoPickerController ()<UICollectionViewDataSource,UICollectionViewDelegate> {
    UICollectionView *_collectionView;
    NSMutableArray *_photoArr;
    
    UIButton *_previewButton;
    UIButton *_okButton;
    UIImageView *_numberImageView;
    UILabel *_numberLable;
    UIButton *_originalPhotoButton;
    UILabel *_originalPhotoLable;
    
    BOOL _isSelectOriginalPhoto;
    BOOL _shouldScrollToBottom;
    
    UIButton *_progressHUD;
    UIView *_HUDContainer;
    UIActivityIndicatorView *_HUDIndicatorView;
    UILabel *_HUDLable;
}
@property (nonatomic, strong) NSMutableArray *selectedPhotoArr;
@property CGRect previousPreheatRect;
@end

static CGSize AssetGridThumbnailSize;

@implementation XYMPhotoPickerController
- (NSMutableArray *)selectedPhotoArr {
    if (_selectedPhotoArr == nil) _selectedPhotoArr = [NSMutableArray array];
    return _selectedPhotoArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _shouldScrollToBottom = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = _model.name;
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];//[UIColor colorWithRed:(49/255.0) green:(50/255.0) blue:(51/255.0) alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    XYMAssetPickerController *imagePickerVc = (XYMAssetPickerController *)self.navigationController;
    [[XYMAssetManager manager] getAssetsFromFetchResult:_model.result allowPickingVideo:imagePickerVc.allowPickingVideo completion:^(NSArray<XYMAsset *> *models) {
        _photoArr = [NSMutableArray arrayWithArray:models];
        [self configCollectionView];
        [self configBottomToolBar];
    }];
    [self resetCachedAssets];
    
    [self configProcessHub];
}

- (void)configProcessHub{
    _progressHUD = [UIButton buttonWithType:UIButtonTypeCustom];
    [_progressHUD setBackgroundColor:[UIColor clearColor]];
    
    _HUDContainer = [[UIView alloc] init];
    _HUDContainer.frame = CGRectMake(0, 0, 120, 90);
    _HUDContainer.layer.cornerRadius = 8;
    _HUDContainer.clipsToBounds = YES;
    _HUDContainer.backgroundColor = [UIColor blackColor];
    _HUDContainer.alpha = 0.7;
    
    _HUDIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _HUDIndicatorView.frame = CGRectMake(45, 15, 30, 30);
    
    _HUDLable = [[UILabel alloc] init];
    _HUDLable.frame = CGRectMake(0,40, 120, 50);
    _HUDLable.textAlignment = NSTextAlignmentCenter;
    _HUDLable.text = @"正在处理...";
    _HUDLable.font = [UIFont systemFontOfSize:15];
    _HUDLable.textColor = [UIColor whiteColor];
    
    _progressHUD.frame = CGRectMake((self.view.xym_view_width - 120) / 2, (self.view.xym_view_height - 90) / 2, 120, 90);;
    [_HUDContainer addSubview:_HUDLable];
    [_HUDContainer addSubview:_HUDIndicatorView];
    [_progressHUD addSubview:_HUDContainer];
    
    _progressHUD.hidden = YES;
    [self.view addSubview:_progressHUD];
}

- (void)configCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat margin = 4;
    CGFloat itemWH = (self.view.xym_view_width - 2 * margin - 4) / 4 - margin;
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    CGFloat top = margin + 44;
    if (iOS7Later) top += 20;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(margin, top, self.view.xym_view_width - 2 * margin, self.view.xym_view_height - 50 - top) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.alwaysBounceHorizontal = NO;
    if (iOS7Later) _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 2);
    _collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, -2);
    _collectionView.contentSize = CGSizeMake(self.view.xym_view_width, ((_model.count + 3) / 4) * self.view.xym_view_width);
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[XYMAssetCell class] forCellWithReuseIdentifier:@"XYMAssetCell"];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_shouldScrollToBottom && _photoArr.count > 0) {
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:(_photoArr.count - 1) inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
        _shouldScrollToBottom = NO;
    }
    // Determine the size of the thumbnails to request from the PHCachingImageManager
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize cellSize = ((UICollectionViewFlowLayout *)_collectionView.collectionViewLayout).itemSize;
    AssetGridThumbnailSize = CGSizeMake(cellSize.width * scale, cellSize.height * scale);    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (iOS8Later) {
        // [self updateCachedAssets];
    }
}

- (void)configBottomToolBar {
    UIView *bottomToolBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.xym_view_height - 50 - kSafeAreaBottomPaddingHeight, self.view.xym_view_width, 50 + kSafeAreaBottomPaddingHeight)];
    CGFloat rgb = 253 / 255.0;
    bottomToolBar.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
    
    _previewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _previewButton.frame = CGRectMake(10, 3, 44, 44);
    [_previewButton addTarget:self action:@selector(previewButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _previewButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_previewButton setTitle:@"预览" forState:UIControlStateNormal];
    [_previewButton setTitle:@"预览" forState:UIControlStateDisabled];
    [_previewButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_previewButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    _previewButton.enabled = NO;
    
    XYMAssetPickerController *imagePickerVc = (XYMAssetPickerController *)self.navigationController;
    if (imagePickerVc.allowPickingOriginalPhoto) {
        _originalPhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _originalPhotoButton.frame = CGRectMake(50, self.view.xym_view_height - 50 - kSafeAreaBottomPaddingHeight, 130, 50);
        _originalPhotoButton.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
        _originalPhotoButton.contentEdgeInsets = UIEdgeInsetsMake(0, -45, 0, 0);
        [_originalPhotoButton addTarget:self action:@selector(originalPhotoButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _originalPhotoButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_originalPhotoButton setTitle:@"原图" forState:UIControlStateNormal];
        [_originalPhotoButton setTitle:@"原图" forState:UIControlStateSelected];
        [_originalPhotoButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_originalPhotoButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_originalPhotoButton setImage:[XYMUIKit imageName:@"photo_original_def" ofBundle:@"Mobile.bundle"] forState:UIControlStateNormal];
        [_originalPhotoButton setImage:[XYMUIKit imageName:@"photo_original_sel" ofBundle:@"Mobile.bundle"] forState:UIControlStateSelected];
        _originalPhotoButton.enabled = _selectedPhotoArr.count > 0;
        
        _originalPhotoLable = [[UILabel alloc] init];
        _originalPhotoLable.frame = CGRectMake(70, 0, 60, 50);
        _originalPhotoLable.textAlignment = NSTextAlignmentLeft;
        _originalPhotoLable.font = [UIFont systemFontOfSize:16];
        _originalPhotoLable.textColor = [UIColor blackColor];
        if (_isSelectOriginalPhoto) [self getSelectedPhotoBytes];
    }
    
    _okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _okButton.frame = CGRectMake(self.view.xym_view_width - 44 - 12, 3, 44, 44);
    _okButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_okButton addTarget:self action:@selector(okButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_okButton setTitle:@"完成" forState:UIControlStateNormal];
    [_okButton setTitle:@"完成" forState:UIControlStateDisabled];
    [_okButton setTitleColor:imagePickerVc.oKButtonTitleColorNormal forState:UIControlStateNormal];
    [_okButton setTitleColor:imagePickerVc.oKButtonTitleColorDisabled forState:UIControlStateDisabled];
    _okButton.enabled = NO;
    
    _numberImageView = [[UIImageView alloc] initWithImage:[XYMUIKit imageName:@"photo_number_icon" ofBundle:@"Mobile.bundle"]];
    _numberImageView.frame = CGRectMake(self.view.xym_view_width - 56 - 24, 12, 26, 26);
    _numberImageView.hidden = _selectedPhotoArr.count <= 0;
    _numberImageView.backgroundColor = [UIColor clearColor];
    
    _numberLable = [[UILabel alloc] init];
    _numberLable.frame = _numberImageView.frame;
    _numberLable.font = [UIFont systemFontOfSize:16];
    _numberLable.textColor = [UIColor whiteColor];
    _numberLable.textAlignment = NSTextAlignmentCenter;
    _numberLable.text = [NSString stringWithFormat:@"%zd",_selectedPhotoArr.count];
    _numberLable.hidden = _selectedPhotoArr.count <= 0;
    _numberLable.backgroundColor = [UIColor clearColor];
    
    UIView *divide = [[UIView alloc] init];
    CGFloat rgb2 = 222 / 255.0;
    divide.backgroundColor = [UIColor colorWithRed:rgb2 green:rgb2 blue:rgb2 alpha:1.0];
    divide.frame = CGRectMake(0, 0, self.view.xym_view_width, 1);
    
    [bottomToolBar addSubview:divide];
    [bottomToolBar addSubview:_previewButton];
    [bottomToolBar addSubview:_okButton];
    [bottomToolBar addSubview:_numberImageView];
    [bottomToolBar addSubview:_numberLable];
    [self.view addSubview:bottomToolBar];
    [self.view addSubview:_originalPhotoButton];
    [_originalPhotoButton addSubview:_originalPhotoLable];
}

#pragma mark - Click Event

- (void)cancel {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    XYMAssetPickerController *imagePickerVc = (XYMAssetPickerController *)self.navigationController;
    if ([imagePickerVc.pickerDelegate respondsToSelector:@selector(imagePickerControllerDidCancel:)]) {
        [imagePickerVc.pickerDelegate imagePickerControllerDidCancel:imagePickerVc];
    }
    if (imagePickerVc.imagePickerControllerDidCancelHandle) {
        imagePickerVc.imagePickerControllerDidCancelHandle();
    }
}

- (void)previewButtonClick {
    XYMPhotoPreviewController *photoPreviewVc = [[XYMPhotoPreviewController alloc] init];
    photoPreviewVc.photoArr = [NSArray arrayWithArray:self.selectedPhotoArr];
    [self pushPhotoPrevireViewController:photoPreviewVc];
}

- (void)originalPhotoButtonClick {
    _originalPhotoButton.selected = !_originalPhotoButton.isSelected;
    _isSelectOriginalPhoto = _originalPhotoButton.isSelected;
    _originalPhotoLable.hidden = !_originalPhotoButton.isSelected;
    if (_isSelectOriginalPhoto) [self getSelectedPhotoBytes];
}

- (void)okButtonClick {
    XYMAssetPickerController *imagePickerVc = (XYMAssetPickerController *)self.navigationController;
    [self showProgressHUD];

    
    [XYMAssetManager manager].shouldFixOrientation = YES;
    
//
//    [self hideProgressHUD];
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableArray *photos = [NSMutableArray array];
        NSMutableArray *assets = [NSMutableArray array];
        NSMutableArray *infoArr = [NSMutableArray array];
        NSMutableArray *imageContentsArr = [NSMutableArray array];
        
        for (NSInteger i = 0; i < _selectedPhotoArr.count; i++) {
            XYMAsset *model = _selectedPhotoArr[i];
        
            [photos addObject:model.previewImage];
            [assets addObject:model];

        }
        
        
        if ([imagePickerVc.pickerDelegate respondsToSelector:@selector(imagePickerController:didFinishPickingPhotos:sourceAssets:)]) {
            [imagePickerVc.pickerDelegate imagePickerController:imagePickerVc didFinishPickingPhotos:photos sourceAssets:assets];
        }
       
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideProgressHUD];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        });
    });
}

- (void)showProgressHUD {
    

    [_HUDIndicatorView startAnimating];
    _HUDIndicatorView.hidden = NO;
    _progressHUD.hidden = NO;
//    [self.view addSubview:_progressHUD];
}

- (void)hideProgressHUD {
    
    [_HUDIndicatorView stopAnimating];
    _progressHUD.hidden = YES;
}


#pragma mark - UICollectionViewDataSource && Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _photoArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XYMAssetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XYMAssetCell" forIndexPath:indexPath];
    XYMAsset *model = _photoArr[indexPath.row];
    cell.model = model;
    
    __weak typeof(cell) weakCell = cell;
    __weak typeof(self) weakSelf = self;
    __weak typeof(_numberImageView.layer) weakLayer = _numberImageView.layer;
    cell.didSelectPhotoBlock = ^(BOOL isSelected) {
        // 取消选择
        if (isSelected) {
            weakCell.selectPhotoButton.selected = NO;
            model.isSelected = NO;
            [weakSelf.selectedPhotoArr removeObject:model];
            [weakSelf refreshBottomToolBarStatus];
        } else {
            // 选择照片,检查是否超过了最大个数的限制
            XYMAssetPickerController *imagePickerVc = (XYMAssetPickerController *)weakSelf.navigationController;
            if (weakSelf.selectedPhotoArr.count < imagePickerVc.maxImagesCount) {
                weakCell.selectPhotoButton.selected = YES;
                model.isSelected = YES;
                [weakSelf.selectedPhotoArr addObject:model];
                [weakSelf refreshBottomToolBarStatus];
            } else {
                [imagePickerVc showAlertWithTitle:[NSString stringWithFormat:@"你最多只能选择%zd张照片",imagePickerVc.maxImagesCount]];
            }
        }
        [UIView showOscillatoryAnimationWithLayer:weakLayer type:WIMOscillatoryAnimationToSmaller];
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XYMAsset *model = _photoArr[indexPath.row];
    if (model.type == XYMAssetMediaTypeVideo) {
        if (_selectedPhotoArr.count > 0) {
            XYMAssetPickerController *imagePickerVc = (XYMAssetPickerController *)self.navigationController;
            [imagePickerVc showAlertWithTitle:@"选择照片时不能选择视频"];
        } else {
            XYMVideoPlayerController *videoPlayerVc = [[XYMVideoPlayerController alloc] init];
            videoPlayerVc.model = model;
            [self.navigationController pushViewController:videoPlayerVc animated:YES];
        }
    } else {
        XYMPhotoPreviewController *photoPreviewVc = [[XYMPhotoPreviewController alloc] init];
        photoPreviewVc.photoArr = _photoArr;
        photoPreviewVc.currentIndex = indexPath.row;
        [self pushPhotoPrevireViewController:photoPreviewVc];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (iOS8Later) {
        // [self updateCachedAssets];
    }
}

#pragma mark - Private Method

- (void)refreshBottomToolBarStatus {
    _previewButton.enabled = self.selectedPhotoArr.count > 0;
    _okButton.enabled = self.selectedPhotoArr.count > 0;
    
    _numberImageView.hidden = _selectedPhotoArr.count <= 0;
    _numberLable.hidden = _selectedPhotoArr.count <= 0;
    _numberLable.text = [NSString stringWithFormat:@"%zd",_selectedPhotoArr.count];
    
    _originalPhotoButton.enabled = _selectedPhotoArr.count > 0;
    _originalPhotoButton.selected = (_isSelectOriginalPhoto && _originalPhotoButton.enabled);
    _originalPhotoLable.hidden = (!_originalPhotoButton.isSelected);
    if (_isSelectOriginalPhoto) [self getSelectedPhotoBytes];
}

- (void)pushPhotoPrevireViewController:(XYMPhotoPreviewController *)photoPreviewVc {
    photoPreviewVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    photoPreviewVc.selectedPhotoArr = self.selectedPhotoArr;
    photoPreviewVc.returnNewSelectedPhotoArrBlock = ^(NSMutableArray *newSelectedPhotoArr,BOOL isSelectOriginalPhoto) {
        _selectedPhotoArr = newSelectedPhotoArr;
        _isSelectOriginalPhoto = isSelectOriginalPhoto;
        [_collectionView reloadData];
        [self refreshBottomToolBarStatus];
    };
    photoPreviewVc.okButtonClickBlock = ^(NSMutableArray *newSelectedPhotoArr,BOOL isSelectOriginalPhoto){
        _selectedPhotoArr = newSelectedPhotoArr;
        _isSelectOriginalPhoto = isSelectOriginalPhoto;
        [self okButtonClick];
    };
    [self.navigationController pushViewController:photoPreviewVc animated:YES];
}

- (void)getSelectedPhotoBytes {
    [[XYMAssetManager manager] getPhotosBytesWithArray:_selectedPhotoArr completion:^(NSString *totalBytes) {
        _originalPhotoLable.text = [NSString stringWithFormat:@"(%@)",totalBytes];
    }];
}

#pragma mark - Asset Caching

- (void)resetCachedAssets {
    [[XYMAssetManager manager].cachingImageManager stopCachingImagesForAllAssets];
    self.previousPreheatRect = CGRectZero;
}

- (void)updateCachedAssets {
    BOOL isViewVisible = [self isViewLoaded] && [[self view] window] != nil;
    if (!isViewVisible) { return; }
    
    // The preheat window is twice the height of the visible rect.
    CGRect preheatRect = _collectionView.bounds;
    preheatRect = CGRectInset(preheatRect, 0.0f, -0.5f * CGRectGetHeight(preheatRect));
    
    /*
     Check if the collection view is showing an area that is significantly
     different to the last preheated area.
     */
    CGFloat delta = ABS(CGRectGetMidY(preheatRect) - CGRectGetMidY(self.previousPreheatRect));
    if (delta > CGRectGetHeight(_collectionView.bounds) / 3.0f) {
        
        // Compute the assets to start caching and to stop caching.
        NSMutableArray *addedIndexPaths = [NSMutableArray array];
        NSMutableArray *removedIndexPaths = [NSMutableArray array];
        
        [self computeDifferenceBetweenRect:self.previousPreheatRect andRect:preheatRect removedHandler:^(CGRect removedRect) {
            NSArray *indexPaths = [self aapl_indexPathsForElementsInRect:removedRect];
            [removedIndexPaths addObjectsFromArray:indexPaths];
        } addedHandler:^(CGRect addedRect) {
            NSArray *indexPaths = [self aapl_indexPathsForElementsInRect:addedRect];
            [addedIndexPaths addObjectsFromArray:indexPaths];
        }];
        
        NSArray *assetsToStartCaching = [self assetsAtIndexPaths:addedIndexPaths];
        NSArray *assetsToStopCaching = [self assetsAtIndexPaths:removedIndexPaths];
        
        // Update the assets the PHCachingImageManager is caching.
        [[XYMAssetManager manager].cachingImageManager startCachingImagesForAssets:assetsToStartCaching
                                                                       targetSize:AssetGridThumbnailSize
                                                                      contentMode:PHImageContentModeAspectFill
                                                                          options:nil];
        [[XYMAssetManager manager].cachingImageManager stopCachingImagesForAssets:assetsToStopCaching
                                                                      targetSize:AssetGridThumbnailSize
                                                                     contentMode:PHImageContentModeAspectFill
                                                                         options:nil];
        
        // Store the preheat rect to compare against in the future.
        self.previousPreheatRect = preheatRect;
    }
}

- (void)computeDifferenceBetweenRect:(CGRect)oldRect andRect:(CGRect)newRect removedHandler:(void (^)(CGRect removedRect))removedHandler addedHandler:(void (^)(CGRect addedRect))addedHandler {
    if (CGRectIntersectsRect(newRect, oldRect)) {
        CGFloat oldMaxY = CGRectGetMaxY(oldRect);
        CGFloat oldMinY = CGRectGetMinY(oldRect);
        CGFloat newMaxY = CGRectGetMaxY(newRect);
        CGFloat newMinY = CGRectGetMinY(newRect);
        
        if (newMaxY > oldMaxY) {
            CGRect rectToAdd = CGRectMake(newRect.origin.x, oldMaxY, newRect.size.width, (newMaxY - oldMaxY));
            addedHandler(rectToAdd);
        }
        
        if (oldMinY > newMinY) {
            CGRect rectToAdd = CGRectMake(newRect.origin.x, newMinY, newRect.size.width, (oldMinY - newMinY));
            addedHandler(rectToAdd);
        }
        
        if (newMaxY < oldMaxY) {
            CGRect rectToRemove = CGRectMake(newRect.origin.x, newMaxY, newRect.size.width, (oldMaxY - newMaxY));
            removedHandler(rectToRemove);
        }
        
        if (oldMinY < newMinY) {
            CGRect rectToRemove = CGRectMake(newRect.origin.x, oldMinY, newRect.size.width, (newMinY - oldMinY));
            removedHandler(rectToRemove);
        }
    } else {
        addedHandler(newRect);
        removedHandler(oldRect);
    }
}

- (NSArray *)assetsAtIndexPaths:(NSArray *)indexPaths {
    if (indexPaths.count == 0) { return nil; }
    
    NSMutableArray *assets = [NSMutableArray arrayWithCapacity:indexPaths.count];
    for (NSIndexPath *indexPath in indexPaths) {
        XYMAsset *model = _photoArr[indexPath.item];
        [assets addObject:model.asset];
    }
    
    return assets;
}

- (NSArray *)aapl_indexPathsForElementsInRect:(CGRect)rect {
    NSArray *allLayoutAttributes = [_collectionView.collectionViewLayout layoutAttributesForElementsInRect:rect];
    if (allLayoutAttributes.count == 0) { return nil; }
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:allLayoutAttributes.count];
    for (UICollectionViewLayoutAttributes *layoutAttributes in allLayoutAttributes) {
        NSIndexPath *indexPath = layoutAttributes.indexPath;
        [indexPaths addObject:indexPath];
    }
    return indexPaths;
}


@end
