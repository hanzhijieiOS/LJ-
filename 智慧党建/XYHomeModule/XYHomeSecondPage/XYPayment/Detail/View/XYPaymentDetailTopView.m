//
//  XYPaymentDetailTopView.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/2/23.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYPaymentDetailTopView.h"

static const float kMarginLeftRight = 12.0f;

static const float kPaddingTop = 15.0f;

@interface XYPaymentDetailTopView()

@property (nonatomic, strong) UILabel * typeLabel;
@property (nonatomic, strong) UILabel * countLabel;
@property (nonatomic, strong) UILabel * timeLabel;

@property (nonatomic, strong) UILabel * type;
@property (nonatomic, strong) UILabel * count;
@property (nonatomic, strong) UILabel * time;

@end

@implementation XYPaymentDetailTopView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.type = [[UILabel alloc] init];
        self.type.text = @"普通党员";
        self.type.textAlignment = NSTextAlignmentRight;
        
        self.typeLabel = [[UILabel alloc] init];
        self.typeLabel.text = @"党员类型:";
        
        self.count = [[UILabel alloc] init];
        self.count.text = @"96.19元";
        self.count.textAlignment = NSTextAlignmentRight;
        
        self.countLabel = [[UILabel alloc] init];
        self.countLabel.text = @"应缴纳党费:";
        
        self.time = [[UILabel alloc] init];
        self.time.text = @"12月份";
        self.time.textAlignment = NSTextAlignmentRight;
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.text = @"月份:";
        
        NSArray * subView = [NSArray arrayWithObjects:self.type, self.typeLabel, self.count, self.countLabel, self.time, self.timeLabel, nil];
        for (UILabel * view in subView) {
            [self addSubview:view];
        }
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kPaddingTop);
        make.left.mas_equalTo(kMarginLeftRight);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(150);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeLabel.mas_bottom).offset(kPaddingTop);
        make.left.equalTo(self.typeLabel);
        make.width.equalTo(self.typeLabel);
        make.height.equalTo(self.typeLabel);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.countLabel.mas_bottom).offset(kPaddingTop);
        make.left.equalTo(self.typeLabel);
        make.width.height.equalTo(self.typeLabel);
    }];
    
    [self.type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(- kMarginLeftRight);
        make.left.equalTo(self.typeLabel.mas_right).offset(kMarginLeftRight);
        make.height.equalTo(self.typeLabel);
        make.top.equalTo(self.typeLabel.mas_top);
    }];
    
    [self.count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.type);
        make.left.equalTo(self.countLabel.mas_right).offset(kMarginLeftRight);
        make.top.height.equalTo(self.countLabel);
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.type);
        make.left.equalTo(self.timeLabel.mas_right).offset(kMarginLeftRight);
        make.top.height.equalTo(self.timeLabel);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
