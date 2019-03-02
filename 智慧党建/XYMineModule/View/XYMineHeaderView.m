//
//  XYMineHeaderView.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/3/2.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYMineHeaderView.h"
#define K_TopGap 13

@implementation XYMineHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.namelabel];
        [self addSubview:self.statusLabel];
        [self addSubview:self.imageView];
        [self addSubview:self.sectionLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.namelabel.frame = CGRectMake(K_LeftGap, K_TopGap, 0, 22);
    [self.namelabel sizeToFit];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.namelabel.mas_bottom);
        make.left.equalTo(self.namelabel.mas_right).offset(3);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(15);
    }];
    
    [self.sectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(K_LeftGap);
        make.bottom.equalTo(self).offset(- K_TopGap);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(150);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.namelabel);
        make.right.equalTo(self).offset(- K_LeftGap);
        make.width.height.mas_equalTo(50);
    }];
    
    self.imageView.layer.cornerRadius = 25;
    self.imageView.layer.masksToBounds = YES;
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.masksToBounds = NO;
    self.layer.cornerRadius = 5;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowPath = shadowPath.CGPath;

}

- (UILabel *)namelabel{
    if (!_namelabel) {
        _namelabel = [[UILabel alloc] init];
        _namelabel.font = [UIFont systemFontOfSize:18 weight:1.7];
        _namelabel.text = @"韩智杰";
    }
    return _namelabel;
}

- (UILabel *)statusLabel{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.font = [UIFont systemFontOfSize:12];
        _statusLabel.text = @"(预备党员)";
    }
    return _statusLabel;
}

- (UILabel *)sectionLabel{
    if (!_sectionLabel) {
        _sectionLabel = [[UILabel alloc] init];
        _sectionLabel.font = [UIFont systemFontOfSize:15];
        _sectionLabel.text = @"西安邮电大学";
    }
    return _sectionLabel;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor yellowColor];
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
