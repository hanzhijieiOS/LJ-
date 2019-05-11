//
//  XYExamHistoryCell.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/11.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYExamHistoryCell.h"
#import "XYExamScoreItemModel.h"

@interface XYExamHistoryCell()

@property (nonatomic, strong) UILabel * titleLabel;

@property (nonatomic, strong) UILabel * timeLabel;

@property (nonatomic, strong) UILabel * totalLabel;

@property (nonatomic, strong) UILabel * scoreLabel;

@end

@implementation XYExamHistoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.scoreLabel];
        [self.contentView addSubview:self.totalLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(K_LeftGap, 6, self.width - 2 * K_LeftGap, 20);
    self.totalLabel.frame = CGRectMake(K_LeftGap, self.titleLabel.bottom + 3, self.titleLabel.width, 17);
    self.scoreLabel.frame = CGRectMake(K_LeftGap, self.totalLabel.bottom + 3, self.titleLabel.width, 17);
    self.timeLabel.frame = CGRectMake(K_LeftGap, self.scoreLabel.bottom + 3, self.titleLabel.width, 17);
}

+ (CGFloat)getCellHeightWithData:(NSObject *)data{
    return 92;
}

- (void)updateContentWithData:(XYExamScoreItemModel *)model{
    self.titleLabel.text = @"测试考试";
    self.totalLabel.text = [NSString stringWithFormat:@"总分：%ld", (long)model.allScore];
    self.scoreLabel.text = [NSString stringWithFormat:@"成绩：%ld", model.score];
    self.timeLabel.text = [NSString stringWithFormat:@"考试时间：%@", model.beginTime];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.backgroundColor = [UIColor whiteColor];
        _timeLabel.textColor = [UIColor grayColor];
    }
    return _timeLabel;
}

- (UILabel *)totalLabel{
    if (!_totalLabel) {
        _totalLabel = [[UILabel alloc] init];
        _totalLabel.font = [UIFont systemFontOfSize:14];
        _totalLabel.backgroundColor = [UIColor whiteColor];
        _totalLabel.textColor = [UIColor grayColor];
    }
    return _totalLabel;
}

- (UILabel *)scoreLabel{
    if (!_scoreLabel) {
        _scoreLabel = [[UILabel alloc] init];
        _scoreLabel.font = [UIFont systemFontOfSize:14];
        _scoreLabel.backgroundColor = [UIColor whiteColor];
        _scoreLabel.textColor = [UIColor grayColor];
    }
    return _scoreLabel;
}

@end
