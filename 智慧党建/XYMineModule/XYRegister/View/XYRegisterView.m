//
//  XYRegisterView.m
//  智慧党建
//
//  Created by jaycehan(韩智杰) on 2019/4/9.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYRegisterView.h"
#import "XYLoginManager.h"
#define K_VerticalGap 24

@interface XYRegisterView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView * bgImage;

@property (nonatomic, strong) UITextField * nameTF;

@property (nonatomic, strong) UITextField * telTF;

@property (nonatomic, strong) UITextField * passwordTF;

@property (nonatomic, strong) UITextField * confirmTF;

@property (nonatomic, strong) UIButton * sendButton;

@property (nonatomic, strong) UITapGestureRecognizer *tapGR;

@end

@implementation XYRegisterView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.nameTF];
        [self addSubview:self.telTF];
        [self addSubview:self.passwordTF];
        [self addSubview:self.confirmTF];
        [self addSubview:self.sendButton];
        [self addGestureRecognizer:self.tapGR];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commitSendButtonStatus) name:UITextFieldTextDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _bgImage.frame = CGRectMake(0, 100, self.width, self.width);
    _nameTF.frame = CGRectMake(K_LeftGap, 50, self.width - 2 * K_LeftGap, 46);
    _telTF.frame = CGRectMake(K_LeftGap, _nameTF.bottom + K_VerticalGap, _nameTF.width, _nameTF.height);
    _passwordTF.frame = CGRectMake(K_LeftGap, _telTF.bottom + K_VerticalGap, _nameTF.width, _nameTF.height);
    _confirmTF.frame = CGRectMake(K_LeftGap, _passwordTF.bottom + K_VerticalGap, _nameTF.width, _nameTF.height);
    _sendButton.frame = CGRectMake(50, _confirmTF.bottom + K_VerticalGap, self.width - 100, 45);
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)commitSendButtonStatus{
    if (_nameTF.text.length && _telTF.text.length && _passwordTF.text.length && _confirmTF.text.length) {
        [_sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _sendButton.enabled = YES;
    }else{
        [_sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _sendButton.enabled = NO;
    }
}

- (void)hidesKeyboard{
    [self endEditing:YES];
}

- (void)keyboardDidHide{
    [self setContentOffset:CGPointZero animated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self setContentOffset:CGPointMake(0, textField.frame.origin.y) animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self hidesKeyboard];
    return YES;
}

- (void)sendButtonDidClick{
    [self hidesKeyboard];
    if ([self.sendDelegate respondsToSelector:@selector(registerViewSendButtonDidClickWithDict:)]) {
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        [dic setObject:self.nameTF.text forKey:@"name"];
        [dic setObject:self.passwordTF.text forKey:@"password"];
        [dic setObject:self.telTF.text forKey:@"tel"];
        [self.sendDelegate registerViewSendButtonDidClickWithDict:dic];
    }
    [AppHelper ShowHUDPrompt:@"正在注册...." withParentViewController:nil];
}

#pragma mark - lazy loading

- (UIImageView *)bgImage{
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _bgImage.image = [UIImage imageNamed:@"dl_danghui.png"];
        _bgImage.backgroundColor = [UIColor whiteColor];
        _bgImage.alpha = 0.2;
    }
    return _bgImage;
}

- (UITextField *)nameTF{
    if (!_nameTF) {
        _nameTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _nameTF.placeholder = @"输入用户名";
        _nameTF.font = [UIFont systemFontOfSize:16];
        [_nameTF setTintColor:[UIColor orangeColor]];
        _nameTF.layer.cornerRadius = 5;
        _nameTF.layer.masksToBounds = YES;
        _nameTF.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:0.5];
        _nameTF.delegate = self;
        _nameTF.returnKeyType = UIReturnKeyDone;
    }
    return _nameTF;
}

- (UITextField *)telTF{
    if (!_telTF) {
        _telTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _telTF.placeholder = @"输入手机号";
        _telTF.font = [UIFont systemFontOfSize:16];
        [_telTF setTintColor:[UIColor orangeColor]];
        _telTF.layer.cornerRadius = 5;
        _telTF.layer.masksToBounds = YES;
        _telTF.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:0.5];
        _telTF.delegate = self;
        _telTF.returnKeyType = UIReturnKeyDone;
    }
    return _telTF;
}

- (UITextField *)passwordTF{
    if (!_passwordTF) {
        _passwordTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _passwordTF.placeholder = @"输入密码";
        _passwordTF.secureTextEntry = YES;
        _passwordTF.font = [UIFont systemFontOfSize:16];
        [_passwordTF setTintColor:[UIColor orangeColor]];
        _passwordTF.layer.cornerRadius = 5;
        _passwordTF.layer.masksToBounds = YES;
        _passwordTF.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:0.5];
        _passwordTF.delegate = self;
        _passwordTF.returnKeyType = UIReturnKeyDone;
    }
    return _passwordTF;
}

- (UITextField *)confirmTF{
    if (!_confirmTF) {
        _confirmTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _confirmTF.placeholder = @"再次输入密码";
        _confirmTF.secureTextEntry = YES;
        _confirmTF.font = [UIFont systemFontOfSize:16];
        [_confirmTF setTintColor:[UIColor orangeColor]];
        _confirmTF.layer.cornerRadius = 5;
        _confirmTF.layer.masksToBounds = YES;
        _confirmTF.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:0.5];
        _confirmTF.delegate = self;
        _confirmTF.returnKeyType = UIReturnKeyDone;
    }
    return _confirmTF;
}

- (UIButton *)sendButton{
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton setTitle:@"注册" forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _sendButton.layer.borderColor = [UIColor orangeColor].CGColor;
        _sendButton.layer.borderWidth = 1.0f;
        _sendButton.layer.cornerRadius = 5.0f;
        _sendButton.layer.masksToBounds = YES;
        [_sendButton setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
        [_sendButton addTarget:self action:@selector(sendButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}

- (UITapGestureRecognizer *)tapGR{
    if (!_tapGR) {
        _tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidesKeyboard)];
    }
    return _tapGR;
}

@end
