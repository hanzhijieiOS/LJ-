//
//  XYMFeedBackController.m
//  MobileApp
//
//  Created by Jay on 2017/7/29.
//  Copyright © 2017年 xiyoumobile. All rights reserved.
//

#import "XYMFeedBackController.h"
#import "XYMAssetPickerController.h"
#import "SDImageCache.h"
#import "XYMAsset.h"
#import "XYMAssetManager.h"
#import "XYMDataCache.h"
#import "XYUtils.h"
#define MAX_LIMIT_NUMS 200

@interface XYMFeedBackController ()<UITextViewDelegate,XYMAssetPickerControllerDelegate>

@property (nonatomic, strong) NSMutableArray<UIImageView *> *images;
@property (nonatomic, strong) NSMutableArray<UIButton *> *buttons;

@property (nonatomic, strong) UIButton *commitButton;

@property (nonatomic, strong) UITextView *contentTextView;

@property (nonatomic, strong) UITextField *contactField;

@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) NSMutableArray *imageDataArray;

@property (nonatomic, strong) UILabel *countLable;

@property (nonatomic, copy) NSString *addImageUrl;

@property (nonatomic, strong) dispatch_semaphore_t semaphore;
//<path,filename>
@property (nonatomic,strong) NSMutableDictionary *files;
//回传的文件路径
@property (nonatomic,copy) NSString *filesPath;

@property (nonatomic,copy) NSString *feedbackContent;
@property (nonatomic,copy) NSString *feedbackContact;
//绑定URL
@property (nonatomic, strong) NSMutableArray<NSString *> *bindDataArray;
//绑定URL与UIImage
@property (nonatomic, strong) NSMutableDictionary<NSString *,XYMAsset*> *bindDataDict;
@end

@implementation XYMFeedBackController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.title = @"问题反馈";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    
    // Do any additional setup after loading the view.
    
    _semaphore = dispatch_semaphore_create(1);
    _files = [[NSMutableDictionary alloc]init];
    [self configSubView];
    [self configSelectImage];
}

- (void)configSubView{
    
    //所有padding = 6
    _images = [[NSMutableArray alloc]init];
    _buttons = [[NSMutableArray alloc]init];
   
    
    //数据绑定
    _bindDataArray = [[NSMutableArray alloc]init];
    _bindDataDict = [[NSMutableDictionary alloc]init];
    
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0,6, SCREENWIDTH, SCREENHEIGHT/2 - 90)];
    _contentView.backgroundColor = [UIColor whiteColor];
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"Mobile" ofType:@"bundle"];
    NSString *keyword = [path stringByAppendingPathComponent:@"增加"];
    if(![_bindDataArray containsObject:keyword]){
        
        XYMAsset *asset = [[XYMAsset alloc]init];
        asset.previewImage = [XYMUIKit imageName:@"增加" ofBundle:@"Mobile.bundle"];
        [_bindDataArray addObject:keyword];
        [_bindDataDict setObject:asset forKey:keyword];
    }
    
    CGRect contentFrame = _contentView.frame;
    
    //文字个数占用中间位置
    _countLable = [[UILabel alloc]initWithFrame:CGRectMake(12, contentFrame.size.height/2 -10, SCREENWIDTH - 24, 14)];
    _countLable.textAlignment = NSTextAlignmentRight;
    _countLable.text = @"0/200";
    [_contentView addSubview:_countLable];
    
    _contentTextView = [[UITextView alloc]initWithFrame:CGRectMake(12, 0, SCREENWIDTH-24,contentFrame.size.height/2 -22 )];
    _contentTextView.text = @"请描述您遇到的问题或您的反馈建议(必填)";
    _contentTextView.textAlignment = NSTextAlignmentLeft;
    _contentTextView.font = [UIFont systemFontOfSize:16];
    _contentTextView.delegate = self;
    [_contentView addSubview:_contentTextView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(12, contentFrame.size.height - 40, SCREENWIDTH - 24, 0.5)];
    line.backgroundColor = [UIColor grayColor];
    [_contentView addSubview:line];
    
    
    _contactField = [[UITextField alloc]initWithFrame:CGRectMake(12, contentFrame.size.height - 40, SCREENWIDTH - 24, 40)];
    
    _contactField.placeholder = @"您的联系方式";
    [_contentView addSubview:_contactField];
    
    _commitButton = [[UIButton alloc]initWithFrame:CGRectMake(12, contentFrame.origin.y + contentFrame.size.height + 12, SCREENWIDTH - 24, 50)];
    [_commitButton setTitle:@"提交" forState:UIControlStateNormal];
    [_commitButton setBackgroundImage:[XYUtils imageWithColor:[XYUtils colorWithRgbHexString:@"0x123456"]] forState:UIControlStateNormal];
    [_commitButton setBackgroundImage:[XYUtils imageWithColor:[XYUtils colorWithRgbHexString:@"0x654321"]] forState:UIControlStateSelected];
    _commitButton.layer.cornerRadius = 5;
    _commitButton.layer.masksToBounds = YES;
    [_commitButton addTarget:self action:@selector(commitClick:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat imageWidth = contentFrame.size.height/2 -64;
    
    if((30 + imageWidth * 4) > SCREENWIDTH ){
        
        imageWidth =( SCREENWIDTH - 30 ) / 4;
    }
    
    
    for(NSInteger i = 0 ; i < 4; i++){
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake( i * (imageWidth + 12) + 12, line.frame.origin.y - imageWidth - 12, imageWidth , imageWidth)];
        
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.masksToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectImage:)];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tap];
        imageView.tag = i;
        [_images  addObject:imageView];
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(imageView.frame.origin.x + imageWidth -7.5, imageView.frame.origin.y-7.5, 15, 15)];
        button.tag = i;
        [button addTarget:self action:@selector(cancleImage:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[XYMUIKit imageName:@"取消" ofBundle:@"Mobile.bundle"] forState:UIControlStateNormal];
        [_buttons addObject:button];
        [_contentView addSubview:imageView];
        [_contentView addSubview:button];
        
    }
    
    [self.view addSubview:_commitButton];
    [self.view addSubview:_contentView];
}

- (void)configSelectImage{
    
    for(int i=0; i< _bindDataArray.count; i++){
        XYMAsset *asset = (XYMAsset *)[_bindDataDict objectForKey: _bindDataArray[i]];
        
        UIImageView *imageView = _images[i];
        imageView.image = asset.previewImage;
        NSString * path = [[NSBundle mainBundle] pathForResource:@"Mobile" ofType:@"bundle"];
        NSString *keyword = [path stringByAppendingPathComponent:@"增加"];
        [_buttons objectAtIndex:i].hidden = NO;
        [_images objectAtIndex:i].hidden = NO;
        if([_bindDataArray[i] isEqualToString:keyword]){
            
            [_buttons objectAtIndex:i].hidden = YES;
        }
    }
    //隐藏没有的Image和取消button
    for(NSInteger i = _images.count - 1; i > _bindDataArray.count - 1; i--){
        
        [_buttons objectAtIndex:i].hidden = YES;
        [_images objectAtIndex:i].hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectImage:(UITapGestureRecognizer *)tap{
    
    UIImageView *imageView = (UIImageView*)tap.view;
    NSString *url = [_bindDataArray objectAtIndex:imageView.tag];
    NSString * path = [[NSBundle mainBundle] pathForResource:@"Mobile" ofType:@"bundle"];
    NSString *keyword = [path stringByAppendingPathComponent:@"增加"];
    if([url isEqualToString:keyword]){
        //打开相册，
        NSString * path = [[NSBundle mainBundle] pathForResource:@"Mobile" ofType:@"bundle"];
        NSString *keyword = [path stringByAppendingPathComponent:@"增加"];
        NSInteger photoCount = [_bindDataArray containsObject:keyword] ? _bindDataDict.count - 1 : _bindDataArray.count;
        NSInteger count = _images.count - photoCount;
        XYMAssetPickerController *imagePickerVc = [[XYMAssetPickerController alloc] initWithMaxImagesCount:count delegate:self];
        imagePickerVc.allowPickingVideo = NO;
        [self presentViewController:imagePickerVc animated:YES completion:nil];
        
    }
}

- (void) commitClick:(id)sender{
    
    //获取
    _feedbackContent = _contentTextView.text;
    _feedbackContact = _contactField.text;
    
    if([XYUtils isEmptyString:_feedbackContent]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请填写反馈内容"
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if([XYUtils isEmptyString:_feedbackContact]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请填写联系方式"
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if(_bindDataArray.count == 1){
        //直接上传信息
        [self feedbackInfo];
    }else{
        //上传文件
        [SVProgressHUD showWithStatus:@"正在处理"];
        NSString * path = [[NSBundle mainBundle] pathForResource:@"Mobile" ofType:@"bundle"];
        NSString *keyword = [path stringByAppendingPathComponent:@"增加"];
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for(int i = 0; i < _bindDataArray.count; i++){
            
            if(![_bindDataArray[i] isEqualToString:keyword]){
                
                [array addObject:[_bindDataDict objectForKey:_bindDataArray[i]]];
            }
        }
        
        [self uploadFile:array];
    }
}

- (void)cancleImage:(id)sender{
    
    UIButton *button = sender;
    NSInteger index = button.tag;
    NSString *key = _bindDataArray[index];
    [self removeBindKey:key];
    [self configSelectImage];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void)imagePickerController:(XYMAssetPickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        for(int i = 0; i< assets.count; i++){
            
            XYMAsset *asset = assets[i];
            [self setBindKey:asset.assetIdentifier data:asset];
        }
        [self configSelectImage];
    });
}

- (void)storeFiles:(NSArray *) assets{
    
    //存储到沙盒路径，不然没有权限上传图片
    __weak  typeof (self)wSelf = self;
    dispatch_barrier_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //等待信号量
        dispatch_semaphore_wait(wSelf.semaphore, DISPATCH_TIME_FOREVER);
        
        for(int i =0; i < assets.count; i++){
            
            XYMAsset *asset = assets[i];
            NSData *data = [[XYMAssetManager manager] getOriginalPhotoDataWithAsset:asset.asset];
            //获取图片名字
            PHAsset *phAsset = asset.asset;
            NSDictionary *info = [[XYMAssetManager manager]getAssetInfoWithAsset:phAsset];
            NSString *key = [[info valueForKey:@"PHImageFileURLKey"] absoluteString];
            NSString *fileName = [key lastPathComponent];
            XYMError *error =  [[XYMDataCache sharedInstance] store:key data:data mediaCacheType:XYMMediaTypeImg mediaCacheOptions:XYMMediaCacheOptionsDisk];
            NSString *filePath = [[XYMDataCache sharedInstance] fileExistsForKey:key mediaCacheType:XYMMediaTypeImg];
            if(filePath){
                [wSelf.files setObject:fileName forKey:filePath];
            }
        }
        dispatch_semaphore_signal(wSelf.semaphore);
    });
    
    
}

- (void)uploadFile:(NSArray *) assets{
    
    [self storeFiles:assets];
    __weak  typeof (self)wSelf = self;
//    dispatch_barrier_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//        //等待信号量
//        dispatch_semaphore_wait(wSelf.semaphore, DISPATCH_TIME_FOREVER);
//
//        NSString *url = @"https://app.xiyou3g.com/res/upload";
    
        //测试文件上传功能
//        [[XYMHttpSessionManager sharedInstance] doPostFile:url withParams:nil withFiles:wSelf.files withHeaders:header progress:^(NSProgress * _Nullable progress) {
//            NSLog(@"%@",progress);
//            dispatch_async(dispatch_get_main_queue(), ^{
//
//                [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"正在上传%.2f",progress.fractionCompleted]];
//            });
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"%@",responseObject);
//            dispatch_semaphore_signal(wSelf.semaphore);
//            NSDictionary *response = responseObject;
//            NSInteger status = [[response objectForKey:@"status"] integerValue];
//            if(status == 0){
//
//                NSArray *data = [response objectForKey:@"data"];
//                _filesPath = [data description];
//                if(wSelf){
//
//                    [wSelf feedbackInfo];
//                }
//            }else{
//
//
//            }
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"%@",error);
//            dispatch_async(dispatch_get_main_queue(), ^{
//
                [SVProgressHUD showErrorWithStatus:@"上传失败"];
//            });
//            dispatch_semaphore_signal(wSelf.semaphore);
//        }];
//    });
//
}

- (void)feedbackInfo{
    
    
//    NSDictionary *parms = nil;
//    if([XYMUtils isEmptyString:_filesPath]){
//
//        parms = @{
//                  @"content":_feedbackContent,
//                  @"contact":_feedbackContact
//                  };
//    }else{
//
//        parms = @{
//                  @"content":_feedbackContent,
//                  @"contact":_feedbackContact,
//                  @"attachments":_filesPath
//                  };
//    }
//    NSDictionary * header = [XYMPublicBaseApi requestPluginHeaderFieldValueDictionary];
//
//    [[XYMHttpSessionManager sharedInstance] doPost:@"https://app.xiyou3g.com/api/mobile/feedback" withParams:parms withHeaders:header progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            [SVProgressHUD showSuccessWithStatus:@"反馈成功"];
//        });
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            [SVProgressHUD showErrorWithStatus:@"反馈失败"];
//        });
//    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)setBindKey:(NSString *)key data:(XYMAsset *)value{
    
    if([_bindDataArray containsObject:key]){
        return;
    }
    NSString * path = [[NSBundle mainBundle] pathForResource:@"Mobile" ofType:@"bundle"];
    NSString *keyword = [path stringByAppendingPathComponent:@"增加"];
    if(![_bindDataArray containsObject:keyword]){
        
        XYMAsset *asset = [[XYMAsset alloc]init];
        asset.previewImage = [XYMUIKit imageName:@"增加" ofBundle:@"Mobile.bundle"];
        [_bindDataArray addObject:keyword];
        [_bindDataDict setObject:asset forKey:keyword];
    }
    if(_bindDataArray.count == 4 && [_bindDataArray containsObject:keyword]){
        
        [_bindDataArray removeObject:keyword];
        [_bindDataDict removeObjectForKey:keyword];
    }
    [_bindDataArray insertObject:key atIndex:0];
    [_bindDataDict setObject:value forKey:key];
}

- (void) removeBindKey:(NSString *)key{
    
    if(![_bindDataArray containsObject:key]){
        return;
    }
    NSString * path = [[NSBundle mainBundle] pathForResource:@"Mobile" ofType:@"bundle"];
    NSString *keyword = [path stringByAppendingPathComponent:@"增加"];
    if(![_bindDataArray containsObject:keyword]){
        
        XYMAsset *asset = [[XYMAsset alloc]init];
        asset.previewImage = [XYMUIKit imageName:@"增加" ofBundle:@"Mobile.bundle"];
        [_bindDataArray addObject:keyword];
        [_bindDataDict setObject:asset forKey:keyword];
    }
    [_bindDataArray removeObject:key];
    [_bindDataDict removeObjectForKey:key];
}

#pragma -mark UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    if (existTextNum >MAX_LIMIT_NUMS){
        
        NSString *s = [nsTextContent substringToIndex:MAX_LIMIT_NUMS];
        [textView setText:s];
    }
    //不让显示负数
    self.countLable.text = [NSString stringWithFormat:@"%ld/%d",MAX(0,MAX_LIMIT_NUMS - existTextNum),MAX_LIMIT_NUMS];
}

@end
