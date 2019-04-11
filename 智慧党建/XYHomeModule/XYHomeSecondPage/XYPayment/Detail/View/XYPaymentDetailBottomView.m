//
//  XYPaymentDetailBottomView.m
//  智慧党建
//
//  Created by jaycehan(韩智杰) on 2019/4/10.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYPaymentDetailBottomView.h"

@interface XYPaymentDetailBottomView ()

@property (nonatomic, strong) UIButton * button;

@end

@implementation XYPaymentDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.backgroundColor = [UIColor redColor];
        [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:self.button];
        [self.button addTarget:self action:@selector(payButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.button.frame = CGRectMake(K_LeftGap, 0, self.width - 2 * K_LeftGap, 44);

}

- (void)payButtonDidClick{
    
}

- (void)setPaymentText:(NSString *)text{
    [self.button setTitle:text forState:UIControlStateNormal];
}

@end
