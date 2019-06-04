//
//  XYDevelopCell.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/27.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYDevelopCell.h"

@interface XYDevelopCell()

@property (nonatomic, strong) UIView * timeView;

@property (nonatomic, strong) UIView * subView;

@property (nonatomic, strong) UILabel * label;

@property (nonatomic, strong) UILabel * timeLabel;

@end

@implementation XYDevelopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.timeView];
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.subView];
        [self.contentView addSubview:self.timeLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.timeView.frame = CGRectMake(70, 0, 2, self.height);
    self.subView.frame = CGRectMake(0, (self.height - 6) / 2.0, 6, 6);
    self.subView.center = self.timeView.center;
    
    [self.timeLabel sizeToFit];
    self.timeLabel.centerY = self.height / 2.0;
    self.timeLabel.right = self.subView.left - 5;
    
    
    [self.label sizeToFit];
    self.label.centerY = self.height / 2.0;
    self.label.left = self.subView.right + 8;
}

- (void)updateWithContent:(NSString *)content time:(NSString *)time color:(UIColor *)color{
    self.label.text = content;
    self.timeView.backgroundColor = color;
    self.label.textColor = color;
    self.subView.backgroundColor = color;
    self.timeLabel.text = time;
    [self setNeedsLayout];
}

+ (NSString *)getCellIdentifierWithData:(NSObject *)data{
    return @"XYDevelopCell";
}

- (UIView *)timeView{
    if (!_timeView) {
        _timeView = [[UIView alloc] init];
    }
    return _timeView;
}

- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.font = [UIFont systemFontOfSize:17];
    }
    return _label;
}

- (UIView *)subView{
    if (!_subView) {
        _subView = [[UIView alloc] init];
        _subView.layer.cornerRadius = 3;
    }
    return _subView;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textColor = [UIColor grayColor];
    }
    return _timeLabel;
}

@end
