//
//  XYChatTableViewCell.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/2/20.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYChatTableViewCell.h"

@interface XYChatTableViewCell()

@property (nonatomic, strong) UIImageView * headImageView;
@property (nonatomic, strong) UIImageView * sendStateView;
@property (nonatomic, strong) UIImageView * contentBGView;

@end

@implementation XYChatTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        self.clipsToBounds = YES;
    }
    return self;
}

+ (CGFloat)getCellHeightWithData:(NSObject *)data{
    return 0;
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
