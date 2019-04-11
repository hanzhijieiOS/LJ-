//
//  XYPayChannelCell.m
//  智慧党建
//
//  Created by jaycehan(韩智杰) on 2019/4/10.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYPayChannelCell.h"

@interface XYPayChannelCell ()

@property (nonatomic, strong) UIImageView * leftImg;

@property (nonatomic, strong) UILabel * titleLabel;

@property (nonatomic, strong) UIImageView * rightImg;

@end

@implementation XYPayChannelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.leftImg];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.rightImg];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.leftImg.frame = CGRectMake(K_LeftGap, (self.height - 25) / 2.0, 25, 25);
    self.titleLabel.frame = CGRectMake(self.leftImg.right + 8, 0, 200, self.height);
    self.rightImg.frame = CGRectMake(self.contentView.width - K_LeftGap - 25, self.leftImg.top, 25, 25);
}

+ (CGFloat)getCellHeightWithData:(NSObject *)data{
    return 44;
}

+ (NSString *)getCellIdentifierWithData:(NSObject *)data{
    return @"XYPayChannelCell";
}

- (void)reloadCellWithData:(NSObject *)data{
    if (![data isKindOfClass:[NSString class]]) {
        return;
    }
    NSString * temp = (NSString *)data;
    self.titleLabel.text = temp;
    self.leftImg.image = [UIImage imageNamed:[[self class] imageName:temp]];
}

+ (NSString *)imageName:(NSString *)text{
    static NSDictionary * map;
    map = @{@"微信支付" : @"weixinzhifu",
            @"支付宝支付" : @"zhifubao"
            };
    return map[text];
}

- (void)setSelectStatus{
    [self.rightImg setImage:[UIImage imageNamed:@"home_pay_select"]];
}

- (void)removeSelectStatus{
    [self.rightImg setImage:[UIImage imageNamed:@"home_pay_deselect"]];
}

- (UIImageView *)leftImg{
    if (!_leftImg) {
        _leftImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _leftImg;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _titleLabel;
}

- (UIImageView *)rightImg{
    if (!_rightImg) {
        _rightImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        _rightImg.image = [UIImage imageNamed:@"home_pay_deselect"];
    }
    return _rightImg;
}

@end
