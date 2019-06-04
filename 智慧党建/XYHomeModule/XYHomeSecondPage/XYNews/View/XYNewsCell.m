//
//  XYNewsCell.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/11.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYNewsCell.h"
#import "XYNewsListItemModel.h"

@interface XYNewsCell()

@property (nonatomic, strong) UIImageView *newsImage;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation XYNewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.newsImage = [[UIImageView alloc] init];
        self.newsImage.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:_newsImage];
        [_newsImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).with.offset(10);
            make.bottom.equalTo(self.mas_bottom).with.offset(-10);
            make.width.equalTo(self.newsImage.mas_height).multipliedBy(4/3.0);
        }];
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.timeLabel];
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        self.timeLabel.font = [UIFont systemFontOfSize:13];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.newsImage.mas_bottom);
            make.right.equalTo(self.mas_right).with.offset(-10);
            make.width.equalTo(@200);
            make.height.equalTo(@17);
        }];
        
        self.contentLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_contentLabel];
        self.contentLabel.numberOfLines = 2;
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.newsImage.mas_top).with.offset(5);
            make.left.equalTo(self.newsImage.mas_right).with.offset(10);
            make.right.equalTo(self.mas_right).with.offset(-10);
//            make.bottom.equalTo(self.mas_bottom).with.offset(-30);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

- (void)updateContentWithData:(XYNewsListItemModel *)data{
    self.timeLabel.text = data.createTime;
    self.contentLabel.text = data.columnName;
    self.contentLabel.backgroundColor = [UIColor yellowColor];
    self.newsImage.backgroundColor = [UIColor lightGrayColor];
}

+ (CGFloat)getCellHeightWithData:(NSObject *)data{
    return 100;
}

@end
