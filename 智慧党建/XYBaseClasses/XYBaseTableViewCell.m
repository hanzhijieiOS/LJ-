//
//  XYBaseTableViewCell.m
//  智慧党建
//
//  Created by 韩智杰 on 2018/12/16.
//  Copyright © 2018年 韩智杰. All rights reserved.
//

#import "XYBaseTableViewCell.h"

@implementation XYBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

+ (CGFloat)getCellHeightWithData:(NSObject *)data{
    return 0;
}

+ (NSString *)getCellIdentifierWithData:(NSObject *)data{
    if (!data) {
        return @"";
    }
    return [NSString stringWithFormat:@"XYCellIdentifier%@",NSStringFromClass([data class])];
}

- (void)reloadCellWithData:(NSObject *)data{
    
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
