//
//  XYRegisterController.m
//  智慧党建
//
//  Created by jaycehan(韩智杰) on 2019/3/10.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYRegisterController.h"
#import "XYRegisterView.h"
#import "XYLoginManager.h"
#import "XYRegisterDataModel.h"

@interface XYRegisterController ()<XYRegisterViewDelegate>

@property (nonatomic, strong) XYRegisterView * registerView;
@property (nonatomic, strong) UIImageView * bgImage;
@property (nonatomic, strong) XYRegisterDataModel * model;

@end

@implementation XYRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"注册";
    [self.view addSubview:self.bgImage];
    self.registerView = [[XYRegisterView alloc] initWithFrame:self.view.bounds];
    self.registerView.sendDelegate = self;
    [self.view addSubview:self.registerView];
    
}

- (void)registerViewSendButtonDidClickWithDict:(NSDictionary *)dict{
    [AppHelper ShowHUDPrompt:@"正在注册"];
    [[XYLoginManager sharedManager] registerWithTel:[dict objectForKey:@"tel"] Password:[dict objectForKey:@"password"] Email:nil Name:[dict objectForKey:@"name"] Birthday:nil Sex:nil succeed:^(XYLoginModel * _Nonnull model) {
        [AppHelper dismissHUDPromptWithAnimation:YES];
    } failureBlock:^(NSError * _Nonnull error) {
        [AppHelper dismissHUDPromptWithAnimation:YES];
    }];
}

- (UIImageView *)bgImage{
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, self.view.width, self.view.width)];
        _bgImage.image = [UIImage imageNamed:@"dl_danghui.png"];
        _bgImage.backgroundColor = [UIColor whiteColor];
        _bgImage.alpha = 0.2;
    }
    return _bgImage;
}

@end
