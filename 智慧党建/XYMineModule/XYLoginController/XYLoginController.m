//
//  XYLoginController.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/1/12.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYLoginController.h"
#import "XYLoginTextField.h"
#define K_LeftGap 12

@interface XYLoginController ()

@property (nonatomic, strong) XYLoginTextField * userName;
@property (nonatomic, strong) XYLoginTextField * password;
@property (nonatomic, strong) UIButton * backButton;

@end

@implementation XYLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView * userView = [[UIView alloc] initWithFrame:CGRectMake(K_LeftGap, 200, self.view.width - 2 * K_LeftGap, 46)];
    userView.layer.cornerRadius = 22;
    userView.layer.borderWidth = 1;
    userView.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor redColor]);
    
    [self.view addSubview:self.userName];
//    self.userName.backgroundColor = [UIColor yellowColor];
//    self.userName.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor redColor]);
//    self.userName.layer.borderWidth = 1;
//    self.userName.layer.cornerRadius = 22;
//    self.userName.layer.masksToBounds = YES;
    [self.view addSubview:self.password];
    [self.view addSubview:self.backButton];
    // Do any additional setup after loading the view.
}

- (void)creatView{
    
}

- (XYLoginTextField *)userName{
    if (!_userName) {
        _userName = [[XYLoginTextField alloc] initWithFrame:CGRectMake(K_LeftGap, 200, self.view.width - 2 * K_LeftGap, 46)];
        _userName.imageView.image = [UIImage imageNamed:@"dl_zhanghao.png"];
        _userName.textField.placeholder = @"账号";
    }
    return _userName;
}

- (XYLoginTextField *)password{
    if (!_password) {
        _password = [[XYLoginTextField alloc] initWithFrame:CGRectMake(K_LeftGap, 270, self.view.width - 2 * K_LeftGap, 46)];
        _password.imageView.image = [UIImage imageNamed:@"dl_mima.png"];
        _password.textField.placeholder = @"密码";
    }
    return _password;
}

- (UIButton *)backButton{
    if (!_backButton) {
        _backButton = [[UIButton alloc] initWithFrame:CGRectMake(K_LeftGap, K_LeftGap + STATUSHEIGHT, 30, 30)];
        [_backButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [_backButton setImage:[UIImage imageNamed:@"cha.png"] forState:UIControlStateNormal];
    }
    return _backButton;
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
