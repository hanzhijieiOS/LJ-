//
//  XYLoginController.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/1/12.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYLoginController.h"
#import "XYLoginTextField.h"
#import "XYLoginManager.h"
#import "XYRegisterController.h"
#define K_LeftGap 12

@interface XYLoginController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) XYLoginTextField * userName;
@property (nonatomic, strong) XYLoginTextField * password;
@property (nonatomic, strong) UIButton * registerBtn;
@property (nonatomic, strong) UIButton * retrieveBtn;

@end

@implementation XYLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.userName];
    [self.view addSubview:self.password];
    [self.view addSubview:self.registerBtn];
    [self.view addSubview:self.retrieveBtn];
    [self.userName.textField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"登陆";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (self.userName.textField.text.length && self.password.textField.text.length) {
        [self login];
        return YES;
    }
    if (textField == self.userName.textField && textField.text.length) {
        [self.password.textField becomeFirstResponder];
        return YES;
    }
    if (textField == self.password.textField && textField.text.length) {
        [self.userName.textField becomeFirstResponder];
        return YES;
    }
    return YES;
}

- (void)login{
    [AppHelper ShowHUDPrompt:@"正在登录...."];
    [[XYLoginManager sharedManager] loginWithAccount:@"12345566423221214" password:@"123212" succeedBlock:^(XYLoginModel * _Nonnull model) {
        [AppHelper dismissHUDPromptWithAnimation:NO];
        [AppHelper ShowHUDPrompt:@"登录成功"];
        [self dismiss];
    } failureBlock:^(NSError * _Nonnull error) {
        [AppHelper dismissHUDPromptWithAnimation:NO];
        [AppHelper ShowHUDPrompt:[NSString stringWithFormat:@"%@",error.domain]];
    }];
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)registerButtonDidClick{
    XYRegisterController * VC = [[XYRegisterController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
//    NSString * URLStr = @"XYMine://Mine/XYRegisterController?Scheme=3";
//    NSString * URLS = [URLStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    NSURL * URL = [NSURL URLWithString:URLS];
//    [[UIApplication sharedApplication] openURL:URL options:[NSDictionary dictionary] completionHandler:nil];
}

#pragma mark - Lazy loading

- (XYLoginTextField *)userName{
    if (!_userName) {
        _userName = [[XYLoginTextField alloc] initWithFrame:CGRectMake(K_LeftGap, 140, self.view.width - 2 * K_LeftGap, 46)];
        _userName.imageView.image = [UIImage imageNamed:@"dl_zhanghao.png"];
        _userName.textField.placeholder = @"账号";
        _userName.textField.delegate = self;
    }
    return _userName;
}

- (XYLoginTextField *)password{
    if (!_password) {
        _password = [[XYLoginTextField alloc] initWithFrame:CGRectMake(K_LeftGap, 210, self.view.width - 2 * K_LeftGap, 46)];
        _password.imageView.image = [UIImage imageNamed:@"dl_mima.png"];
        _password.textField.placeholder = @"密码";
        _password.textField.secureTextEntry = YES;
        _password.textField.delegate = self;
    }
    return _password;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 80, 80)];
        _imageView.centerX = self.view.width / 2.0;
        _imageView.image = [UIImage imageNamed:@"dl_danghui.png"];
    }
    return _imageView;
}

- (UIButton *)registerBtn{
    if (!_registerBtn) {
        _registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.password.bottom + 22, 70, 22)];
        _registerBtn.right = self.view.width - K_LeftGap;
        [_registerBtn setTitle:@"注册账号" forState:UIControlStateNormal];
        [_registerBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_registerBtn setTitleColor:[UIColor colorWithRed:69 / 255.0 green:139 / 255.0 blue:246 / 255.0 alpha:1] forState:UIControlStateNormal];
        [_registerBtn setBackgroundColor:[UIColor whiteColor]];
        [_registerBtn addTarget:self action:@selector(registerButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}

- (UIButton *)retrieveBtn{
    if (!_retrieveBtn) {
        _retrieveBtn = [[UIButton alloc] initWithFrame:CGRectMake(K_LeftGap, self.password.bottom + 20, 70, 22)];
        [_retrieveBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_retrieveBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_retrieveBtn setTitleColor:[UIColor colorWithRed:69 / 255.0 green:139 / 255.0 blue:246 / 255.0 alpha:1] forState:UIControlStateNormal];
        [_retrieveBtn setBackgroundColor:[UIColor whiteColor]];
    }
    return _retrieveBtn;
}

@end
