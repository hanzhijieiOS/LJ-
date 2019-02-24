//
//  XYBaseTableViewCell.h
//  智慧党建
//
//  Created by 韩智杰 on 2018/12/16.
//  Copyright © 2018年 韩智杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYBaseTableViewCell : UITableViewCell

+ (CGFloat)getCellHeightWithData:(NSObject *)data;

+ (NSString *)getCellIdentifierWithData:(NSObject *)data;

- (void)reloadCellWithData:(NSObject *)data;

@end
