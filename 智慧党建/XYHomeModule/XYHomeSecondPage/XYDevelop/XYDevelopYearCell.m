//
//  XYDevelopYearCell.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/30.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYDevelopYearCell.h"

@interface XYDevelopYearCell()

@property (nonatomic, strong) UIImageView * imgView;

@property (nonatomic, strong) UILabel * contentLabel;

@property (nonatomic, strong) UIView * lineView;

@end

@implementation XYDevelopYearCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.imgView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.lineView.frame = CGRectMake(70, 0, 2, self.height);
    self.imgView.frame = CGRectMake(0, 0, 20, 20);
    self.imgView.centerY = self.height / 2.0;
    self.imgView.centerX = self.lineView.centerX;
    
    [self.contentLabel sizeToFit];
    self.contentLabel.left = self.imgView.right + 8;
    self.contentLabel.centerY = self.height / 2.0;
}

- (void)updateWithTime:(NSString *)time color:(UIColor *)color{
    self.contentLabel.text = time;
    self.lineView.backgroundColor = color;
}

+ (NSString *)getCellIdentifierWithData:(NSObject *)data{
    return @"XYDevelopYearCell";
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"时间.png"]];
        _imgView.backgroundColor = [UIColor whiteColor];
    }
    return _imgView;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:25];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textColor = [UIColor greenColor];
    }
    return _contentLabel;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
    }
    return _lineView;
}

@end
