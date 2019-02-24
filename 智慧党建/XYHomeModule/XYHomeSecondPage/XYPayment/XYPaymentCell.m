//
//  XYPaymentCell.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/2/23.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYPaymentCell.h"

@interface XYPaymentCell()

@property (nonatomic, strong) UIImageView * leftImgView;
@property (nonatomic, strong) UIImageView * imgView;

@end

@implementation XYPaymentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weijiaofei.png"]];
        [self.contentView addSubview:self.imgView];
        
        self.leftImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dian.png"]];
        [self.contentView addSubview:self.leftImgView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.leftImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(6);
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_equalTo(20);
    }];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(45.3);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImgView.mas_right);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(200);
    }];
}

+ (CGFloat)getCellHeightWithData:(NSObject *)data{
    return 44;
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
