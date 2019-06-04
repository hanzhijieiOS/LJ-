//
//  XYExamTableViewCell.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/9.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYExamListCell.h"
#import "XYExamInfoModel.h"
#define KLeftMargin 12
#define KTopMargin 6
#define KSubviewsMargin 8

@interface XYExamListCell()

@property (nonatomic, strong) UILabel * titleLabel;

@property (nonatomic, strong) UILabel * unitLabel;

@property (nonatomic, strong) UILabel * timeLabel;

@property (nonatomic, strong) UILabel * responsible;

@property (nonatomic, strong) UIImageView * imgView;

@property (nonatomic, strong) XYExamInfoModel * model;

@end

@implementation XYExamListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.unitLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.responsible];
        [self.contentView addSubview:self.imgView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imgView.frame = CGRectMake(KLeftMargin, (self.height - 67) / 2.0, 90, 67);
    CGFloat labelWidth = self.width - 2 * KLeftMargin - 90 - KSubviewsMargin;
    self.titleLabel.frame = CGRectMake(self.imgView.right + KSubviewsMargin, self.imgView.top, labelWidth, 20);
    self.unitLabel.frame = CGRectMake(self.titleLabel.left, self.titleLabel.bottom + 3, labelWidth, 15);
    self.timeLabel.frame = CGRectMake(self.titleLabel.left, self.unitLabel.bottom + 0, labelWidth, 15);
    self.responsible.frame = CGRectMake(self.titleLabel.left, self.timeLabel.bottom + 0, labelWidth, 15);
}

+ (CGFloat)getCellHeightWithData:(NSObject *)data{
    return 86;
}

- (void)updateContentWithData:(XYExamInfoModel *)dataModel{
    if ([dataModel isKindOfClass:[NSDictionary class]]) {
        NSDictionary * dic = (NSDictionary *)dataModel;
        self.titleLabel.text = [dic objectForKey:@"examPaperName"];
        self.unitLabel.text = [NSString stringWithFormat:@"发布部门：%@", [dic objectForKey:@"createUnit"]];
        self.timeLabel.text = [NSString stringWithFormat:@"考试时间：%@", [dic objectForKey:@"invalidTime"]];
        self.responsible.text = [NSString stringWithFormat:@"考试主管：%@", [dic objectForKey:@"responsible"]];
    }else{
        self.model = dataModel;
        self.titleLabel.text = dataModel.examPaperName;
        self.unitLabel.text = [NSString stringWithFormat:@"发布部门：%@", dataModel.createUnit];
        self.timeLabel.text = [NSString stringWithFormat:@"考试时间：%@", dataModel.invalidTime];
        self.responsible.text = [NSString stringWithFormat:@"考试主管：%@", dataModel.responsible];
    }
    self.imgView.backgroundColor = [UIColor whiteColor];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"dl_danghui.png"]];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UILabel *)unitLabel{
    if (!_unitLabel) {
        _unitLabel = [[UILabel alloc] init];
        _unitLabel.font = [UIFont systemFontOfSize:12];
        _unitLabel.textColor = [UIColor grayColor];
    }
    return _unitLabel;
}

- (UILabel *)responsible{
    if (!_responsible) {
        _responsible = [[UILabel alloc] init];
        _responsible.textColor = [UIColor grayColor];
        _responsible.font = [UIFont systemFontOfSize:12];
    }
    return _responsible;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _timeLabel;
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgView;
}

@end
