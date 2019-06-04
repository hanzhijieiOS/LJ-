//
//  NewsTableViewCell.h
//  知途趣闻
//
//  Created by Jay on 2017/10/25.
//  Copyright © 2017年 hanzhijie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZJNewsModel.h"

@interface NewsTableViewCell : UITableViewCell

//- (void)updateViewWithNewsItemModel:(HZJNewsItemModel *)newsItemModel;
- (void)updateViewWithNewsItemModel:(id)newsItemModel;

- (void)clearContent;

@property (nonatomic, strong) id data;

@end
