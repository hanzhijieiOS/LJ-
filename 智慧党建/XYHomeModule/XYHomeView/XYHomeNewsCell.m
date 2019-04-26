//
//  XYHomeNewsCell.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/2/23.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYHomeNewsCell.h"

static const float kMarginLeftRight = 12.0f;

static const float kPaddingBottom = 12.0f;

static const float kPaddingTop = 15.0f;

static const float kCellHeight = 86.0f;

@interface XYHomeNewsCell()

@property (nonatomic, strong) UIImageView * imgView;
@property (nonatomic, strong) UILabel * itemLabel;
@property (nonatomic, strong) UILabel * timeLabel;

@end

@implementation XYHomeNewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.itemLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.itemLabel.numberOfLines = 2;
        self.itemLabel.font = [UIFont systemFontOfSize:15];
        self.itemLabel.text = @"习近平出席第二届“一带一路”国际合作高峰论坛开幕式\n";
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        self.timeLabel.text = @"2019.4.24 14:12:36";
        [self.contentView addSubview:self.imgView];
        self.imgView.backgroundColor = [UIColor grayColor];
        
        [self.contentView addSubview:self.itemLabel];
        self.itemLabel.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.timeLabel];
        self.timeLabel.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kCellHeight - kPaddingTop - kPaddingBottom);
        make.width.mas_equalTo((kCellHeight - kPaddingTop - kPaddingBottom) * 1.5);
        make.top.mas_equalTo(kPaddingTop);
        make.right.equalTo(self.contentView).offset(-kMarginLeftRight);
    }];
    [self.itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMarginLeftRight);
        make.top.mas_equalTo(kPaddingTop);
        make.height.mas_equalTo(37);
        make.right.equalTo(self.imgView.mas_left).offset(-kMarginLeftRight);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.itemLabel);
        make.top.equalTo(self.itemLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(17);
        make.width.mas_equalTo(200);
    }];
}

+ (CGFloat)getCellHeightWithData:(NSObject *)data{
    return kCellHeight;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
