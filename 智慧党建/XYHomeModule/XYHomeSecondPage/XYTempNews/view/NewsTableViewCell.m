//
//  NewsTableViewCell.m
//  知途趣闻
//
//  Created by Jay on 2017/10/25.
//  Copyright © 2017年 hanzhijie. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface NewsTableViewCell()

@property (nonatomic, strong) UIImageView *newsImage;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, assign) BOOL drawed;

@end

@implementation NewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.drawed = NO;
        [self layout];
    }
    return self;
}

- (void)layout{
    self.newsImage = [[UIImageView alloc] init];
    self.newsImage.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_newsImage];
    [_newsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).with.offset(10);
        make.bottom.equalTo(self.mas_bottom).with.offset(-10);
        make.width.equalTo(self.newsImage.mas_height).multipliedBy(4/3.0);
    }];
    
    self.timeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.timeLabel];
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.newsImage.mas_bottom);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.width.equalTo(@120);
        make.height.equalTo(@17);
    }];
    
    self.contentLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_contentLabel];
    self.contentLabel.numberOfLines = 2;
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.newsImage.mas_top);
        make.left.equalTo(self.newsImage.mas_right).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.bottom.equalTo(self.mas_bottom).with.offset(-30);
    }];
}

- (void)updateViewWithNewsItemModel:(id)newsItemModel{
//    if ([[newsItemModel class] isSubclassOfClass:[HZJNewsItemModel class]]) {
//        HZJNewsItemModel *model = newsItemModel;
//    if (self.drawed) {
//        return;
//    }
//    self.drawed = YES;
    HZJNewsItemModel *model = newsItemModel;
        self.timeLabel.text = model.date;
        [self.newsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.thumbnail_pic_s]] placeholderImage:[UIImage imageNamed:@""]];
        self.contentLabel.text = model.title;
//    }
}

- (void)clearContent{
    if (!self.drawed) {
        return;
    }
    self.timeLabel.text = @"";
    self.contentLabel.text = @"";
    self.newsImage.image = nil;
    self.drawed = NO;
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
