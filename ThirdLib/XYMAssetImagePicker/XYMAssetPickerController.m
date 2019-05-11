

#import "XYMAssetPickerController.h"
#import "XYMPhotoPickerController.h"
#import "XYMPhotoPreviewController.h"
#import "XYMAsset.h"
#import "XYMAssetCell.h"
#import "UIView+XYMExtension.h"
#import "XYMAssetManager.h"
#import "XYMAssetConstants.h"

@interface XYMAssetPickerController ()
{
    NSTimer *_timer;
    UILabel *_tipLable;
    BOOL _pushToPhotoPickerVc;
    
    UIButton *_progressHUD;
    UIView *_HUDContainer;
    UIActivityIndicatorView *_HUDIndicatorView;
    UILabel *_HUDLable;
    
    UIStatusBarStyle _originStatusBarStyle;
}
@end

@implementation XYMAssetPickerController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [XYMAssetManager manager].shouldFixOrientation = NO;
    
    // 默认的外观，你可以在这个方法后重置
    self.oKButtonTitleColorNormal   = [UIColor colorWithRed:(83/255.0) green:(179/255.0) blue:(17/255.0) alpha:1.0];
    self.oKButtonTitleColorDisabled = [UIColor colorWithRed:(83/255.0) green:(179/255.0) blue:(17/255.0) alpha:0.5];
    
    if (iOS7Later) {
//        self.navigationBar.barTintColor = [UIColor colorWithRed:(34/255.0) green:(34/255.0)  blue:(34/255.0) alpha:1.0];
//       self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:(49/255.0) green:(50/255.0) blue:(51/255.0) alpha:1.0];
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    UIBarButtonItem *barItem;
    if (iOS9Later) {
        barItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[XYMAssetPickerController class]]];
    } else {
        barItem = [UIBarButtonItem appearanceWhenContainedIn:[XYMAssetPickerController class], nil];
    }
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [barItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan = NO;
    __weak typeof(self) weakSelf = self;
    
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
    }
    
    [self configProcessHub];
}

- (void)configProcessHub{
    _progressHUD = [UIButton buttonWithType:UIButtonTypeCustom];
    [_progressHUD setBackgroundColor:[UIColor clearColor]];
    
    _HUDContainer = [[UIView alloc] init];
    _HUDContainer.frame = CGRectMake(0, 0, 120, 90);
    _HUDContainer.layer.cornerRadius = 8;
    _HUDContainer.clipsToBounds = YES;
    _HUDContainer.backgroundColor = [UIColor whiteColor];
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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _originStatusBarStyle = [UIApplication sharedApplication].statusBarStyle;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = _originStatusBarStyle;
}

- (instancetype)initWithMaxImagesCount:(NSInteger)maxImagesCount delegate:(id<XYMAssetPickerControllerDelegate>)delegate {
    XYMAlbumPickerController *albumPickerVc = [[XYMAlbumPickerController alloc] init];
    self = [super initWithRootViewController:albumPickerVc];
    if (self) {
        self.maxImagesCount = maxImagesCount > 0 ? maxImagesCount : 9; // Default is 9 / 默认最大可选9张图片
        self.pickerDelegate = delegate;
        // 默认准许用户选择原图和视频, 你也可以在这个方法后置为NO
        _allowPickingOriginalPhoto = YES;
        _allowPickingVideo = YES;
        
        if (![[XYMAssetManager manager] authorizationStatusAuthorized]) {
            _tipLable = [[UILabel alloc] init];
            _tipLable.frame = CGRectMake(8, 0, self.view.xym_view_width - 16, 300);
            _tipLable.textAlignment = NSTextAlignmentCenter;
            _tipLable.numberOfLines = 0;
            _tipLable.font = [UIFont systemFontOfSize:16];
            _tipLable.textColor = [UIColor blackColor];
            NSString *appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleDisplayName"];
            if (!appName) appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleName"];
            _tipLable.text = [NSString stringWithFormat:@"请在%@的\"设置-隐私-照片\"选项中，\r允许%@访问你的手机相册。",[UIDevice currentDevice].model,appName];
            [self.view addSubview:_tipLable];
            
            _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(observeAuthrizationStatusChange) userInfo:nil repeats:YES];
        } else {
            [self pushToPhotoPickerVc];
        }
    }
    return self;
}

- (void)observeAuthrizationStatusChange {
    if ([[XYMAssetManager manager] authorizationStatusAuthorized]) {
        [self pushToPhotoPickerVc];
        [_tipLable removeFromSuperview];
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)pushToPhotoPickerVc {
    _pushToPhotoPickerVc = YES;
    if (_pushToPhotoPickerVc) {
        XYMPhotoPickerController *photoPickerVc = [[XYMPhotoPickerController alloc] init];
        [[XYMAssetManager manager] getCameraRollAlbum:self.allowPickingVideo completion:^(XYMAlbum *model) {
            photoPickerVc.model = model;
            [self pushViewController:photoPickerVc animated:YES];
            _pushToPhotoPickerVc = NO;
        }];
    }
}

- (void)showAlertWithTitle:(NSString *)title {
    if (iOS8Later) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        [[[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil] show];
    }
}

- (void)showProgressHUD {
    
//    UIView *view  = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 200, 100)];
//    view.backgroundColor = [UIColor grayColor];
//    [[[UIApplication sharedApplication].delegate window] addSubview:view];
    if (!_progressHUD) {
        _progressHUD = [UIButton buttonWithType:UIButtonTypeCustom];
        [_progressHUD setBackgroundColor:[UIColor clearColor]];
        
        _HUDContainer = [[UIView alloc] init];
        _HUDContainer.frame = CGRectMake(0, 0, 120, 90);
        _HUDContainer.layer.cornerRadius = 8;
        _HUDContainer.clipsToBounds = YES;
        _HUDContainer.backgroundColor = [UIColor darkGrayColor];
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
        
    }
    [_HUDIndicatorView startAnimating];
    _HUDIndicatorView.hidden = NO;
    _progressHUD.hidden = NO;
    [[[UIApplication sharedApplication].delegate window] addSubview:_progressHUD];
}

- (void)hideProgressHUD {
    if (_progressHUD) {
        [_HUDIndicatorView stopAnimating];
        [_progressHUD removeFromSuperview];
        _progressHUD.hidden = YES;
    }
    _progressHUD.hidden = YES;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (iOS7Later) viewController.automaticallyAdjustsScrollViewInsets = NO;
    if (_timer) { [_timer invalidate]; _timer = nil;}
    
    if (self.childViewControllers.count > 0) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 50, 44);
        [backButton setTintColor:[UIColor whiteColor]];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UIImage *image = [XYMUIKit imageName:@"navi_back" ofBundle:@"Mobile.bundle"];
        [backButton setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        [backButton setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateHighlighted];
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
        backButton.titleEdgeInsets = UIEdgeInsetsMake(0, -8.5, 0, 0);
        [backButton setTitle:@"相薄" forState:UIControlStateNormal];
        backButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [backButton addTarget:self action:@selector(popViewController:) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }

    [super pushViewController:viewController animated:animated];
}

- (void)popViewController:(UIButton *)sender {
    [self popViewControllerAnimated:YES];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        
    }
    return [super popViewControllerAnimated:animated];
}
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    // Enable the gesture again once the new controller is shown
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        if (self.viewControllers.count ==1) {
            self.interactivePopGestureRecognizer.enabled = NO;
        }
        else
        {
            self.interactivePopGestureRecognizer.enabled = YES;
            self.interactivePopGestureRecognizer.delaysTouchesBegan = NO;
        }
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.viewControllers.count == 1)//关闭主界面的右滑返回
        return NO;
    return YES;
}

@end

@interface XYMAlbumPickerController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_albumArr;

}
@end
@implementation XYMAlbumPickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"相薄";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    [self configTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    XYMAssetPickerController *imagePickerVc = (XYMAssetPickerController *)self.navigationController;
    [imagePickerVc hideProgressHUD];
    if (_albumArr) return;
    [self configTableView];
}

- (void)configTableView {
    XYMAssetPickerController *imagePickerVc = (XYMAssetPickerController *)self.navigationController;
    [[XYMAssetManager manager] getAllAlbums:imagePickerVc.allowPickingVideo completion:^(NSArray<XYMAlbum *> *models) {
        _albumArr = [NSMutableArray arrayWithArray:models];
        
        CGFloat top = 44;
        if (iOS7Later) top += 20;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, top, self.view.xym_view_width, self.view.xym_view_height - top) style:UITableViewStylePlain];
        _tableView.rowHeight = 70;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[XYMAlbumCell class] forCellReuseIdentifier:@"XYMAlbumCell"];
        [self.view addSubview:_tableView];
    }];
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

#pragma mark - UITableViewDataSource && Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _albumArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYMAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XYMAlbumCell"];
    cell.model = _albumArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
//        [cell setSeparatorInset:UIEdgeInsetsMake(0, 95, 0, 0)];
        cell.separatorInset = UIEdgeInsetsMake(0.f, cell.bounds.size.width, 0.f, 0.f);
    }
    
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
    {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if (indexPath.row == _albumArr.count - 1) {
        cell.separatorInset = UIEdgeInsetsMake(0.f, cell.bounds.size.width, 0.f, 0.f);
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XYMPhotoPickerController *photoPickerVc = [[XYMPhotoPickerController alloc] init];
    photoPickerVc.model = _albumArr[indexPath.row];
    [self.navigationController pushViewController:photoPickerVc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.0;
}

@end
