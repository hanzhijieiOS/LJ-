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
    self.imageView.frame = CGRectMake(1, 1, self.height - 2, self.height - 2);
    self.textField.frame = CGRectMake(self.imageView.left + 2, 1, self.width - self.imageView.right - 3, self.height - 2);
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(22, 22)];
    path.lineWidth = 1;
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = path.CGPath;
    maskLayer.strokeColor = [UIColor redColor].CGColor;
    maskLayer.fillColor = [UIColor yellowColor].CGColor;
    self.layer.mask = maskLayer;
    self.layer.masksToBounds = YES;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.font = [UIFont systemFontOfSize:16];
        [_textField setTintColor:[UIColor orangeColor]];
    }
    return _textField;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
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
