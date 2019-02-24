//
//  XYRegulationCell.m
//  智慧党建
//
//  Created by jaycehan(韩智杰) on 2019/2/24.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYRegulationCell.h"

static const float kMarginLeftRight = 12.0f;

static const float kPaddingBottom = 12.0f;

static const float kPaddingTop = 12.0f;

static const float kCellHeight = 86.0f;

@interface XYRegulationCell()

@property (nonatomic, strong) UIImageView * imgView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * countLabel;
@property (nonatomic, strong) UILabel * actorLabel;
@property (nonatomic, strong) UILabel * timeLabel;

@end



@implementation XYRegulationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imgView];
        
        self.imgView.backgroundColor = [UIColor grayColor];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.nameLabel];
        self.nameLabel.text = @"党章";
        self.nameLabel.font = [UIFont systemFontOfSize:15];
        
        self.countLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.countLabel];
        self.countLabel.text = @"已学习：153次 | 收藏：42人";
        self.countLabel.font = [UIFont systemFontOfSize:10];
        self.countLabel.textColor = [UIColor grayColor];
        
        self.actorLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.actorLabel];
        self.actorLabel.textColor = [UIColor grayColor];
        self.actorLabel.font = [UIFont systemFontOfSize:11];
        self.actorLabel.text = @"主讲人：振涛";
        
        self.timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.timeLabel];
        self.timeLabel.textColor = [UIColor grayColor];
        self.timeLabel.font = [UIFont systemFontOfSize:11];
        self.timeLabel.text = @"2019-02-22 10:52:23";
    }
    return self;
}

+ (CGFloat)getCellHeightWithData:(NSObject *)data{
    return kCellHeight;
}

+ (NSString *)getCellIdentifierWithData:(NSObject *)data{
    return @"XYRegulationCell";
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kMarginLeftRight);
        make.top.equalTo(self.contentView).offset(kPaddingTop);
        make.bottom.equalTo(self.contentView).offset(- kPaddingBottom);
        make.width.mas_equalTo((kCellHeight - kPaddingTop - kPaddingBottom) * 1.5);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView.mas_right).offset(kMarginLeftRight);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
        make.top.equalTo(self.imgView).offset(-2);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
        make.top.equalTo(self.nameLabel.mas_bottom);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(200);
        make.bottom.equalTo(self.imgView.mas_bottom).offset(2);
    }];
    
    [self.actorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.bottom.equalTo(self.timeLabel.mas_top);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
    }];
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
