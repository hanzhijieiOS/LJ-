//
//  XYInfomationCell.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/28.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYInfomationCell.h"

@interface XYInfomationCell()

@property (nonatomic, strong) UILabel * itemLabel;

@property (nonatomic, strong) UILabel * dataLabel;

@end

@implementation XYInfomationCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.dataLabel];
        [self.contentView addSubview:self.itemLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.itemLabel.frame = CGRectMake(K_LeftGap, 0, 0, self.height);
    [self.itemLabel sizeToFit];
    self.itemLabel.centerY = self.height / 2.0;
    
    
    self.dataLabel.frame = CGRectMake(0, 0, 0, self.height);
    [self.dataLabel sizeToFit];
    self.dataLabel.right = self.width - K_LeftGap;
    self.dataLabel.centerY = self.height / 2.0;
}

- (void)updateContentWithItem:(NSString *)item data:(NSString *)data{
    if ([item isEqualToString:@"性别"]) {
        self.dataLabel.text = [data isEqualToString:@"1"] ? @"男" : @"女";
    }else{
        self.dataLabel.text = data;
    }
    self.itemLabel.text = item;
    
}

- (UILabel *)dataLabel{
    if (!_dataLabel) {
        _dataLabel = [[UILabel alloc] init];
        _dataLabel.textColor = [UIColor blackColor];
        _dataLabel.textAlignment = NSTextAlignmentRight;
    }
    return _dataLabel;
}

- (UILabel *)itemLabel{
    if (!_itemLabel) {
        _itemLabel = [[UILabel alloc] init];
        _itemLabel.textColor = [UIColor grayColor];
    }
    return _itemLabel;
}


@end
