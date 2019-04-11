//
//  XYRegulationCell_V2.m
//  智慧党建
//
//  Created by jaycehan(韩智杰) on 2019/4/11.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYRegulationCell_V2.h"

static const float kMarginLeftRight = 12.0f;

static const float kPaddingTop = 12.0f;

static const float kCellHeight = 86.0f;

@interface XYRegulationCell_V2 ()

@property (nonatomic, strong) UIImageView * leftImgView;

@property (nonatomic, strong) UILabel * titleLabel;

@property (nonatomic, strong) UILabel * subtitleLabel;

@end

@implementation XYRegulationCell_V2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.leftImgView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.subtitleLabel];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.leftImgView.frame = CGRectMake(K_LeftGap, kPaddingTop, (kCellHeight - 2 * kPaddingTop) / 3.0 * 4, kCellHeight - 2 * kPaddingTop);
    self.titleLabel.frame = CGRectMake(self.leftImgView.right + kMarginLeftRight, kPaddingTop + 3, self.contentView.width - self.leftImgView.right - 2 * kMarginLeftRight, 20);
    self.subtitleLabel.frame = CGRectMake(self.titleLabel.left, self.leftImgView.bottom - 20, self.titleLabel.width, 15);
}

+ (CGFloat)getCellHeightWithData:(NSObject *)data{
    return kCellHeight;
}

+ (NSString *)getCellIdentifierWithData:(NSObject *)data{
    return NSStringFromClass([self class]);
}

- (void)updateTitlt:(NSString *)title subTitle:(NSString *)subTitle{
    self.titleLabel.text = title;
    self.subtitleLabel.text = subTitle;
}

- (UIImageView *)leftImgView{
    if (!_leftImgView) {
        _leftImgView = [[UIImageView alloc] init];
        _leftImgView.contentMode = UIViewContentModeScaleAspectFit;
        _leftImgView.image = [UIImage imageNamed:@"dangzhang"];
    }
    return _leftImgView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel{
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.font = [UIFont systemFontOfSize:12];
        _subtitleLabel.textColor = [UIColor grayColor];
    }
    return _subtitleLabel;
}

@end
