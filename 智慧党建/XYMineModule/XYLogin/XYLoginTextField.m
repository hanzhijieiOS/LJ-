//
//  XYLoginTextField.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/3/3.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYLoginTextField.h"

@implementation XYLoginTextField

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageView];
        [self addSubview:self.textField];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.textField.frame = CGRectMake(1, 1, self.width - 2, self.height - 2);
    self.imageView.frame = CGRectMake(1, 5, self.textField.height - 10, self.textField.height - 10);
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.font = [UIFont systemFontOfSize:16];
        [_textField setTintColor:[UIColor orangeColor]];
        _textField.layer.cornerRadius = 5;
        _textField.layer.masksToBounds = YES;
        _textField.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
        _textField.leftView = self.imageView;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.returnKeyType = UIReturnKeyDone;
    }
    return _textField;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
