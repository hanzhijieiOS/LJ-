//
//  XYHomeCollectionViewCell.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/2/23.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYHomeCollectionViewCell.h"

@interface XYHomeCollectionViewCell()

@end

@implementation XYHomeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.imageView];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(20);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.imageView.mas_bottom).offset(10);
        make.width.mas_equalTo(self.width - 10);
        make.height.mas_equalTo(20);
    }];
}

@end
