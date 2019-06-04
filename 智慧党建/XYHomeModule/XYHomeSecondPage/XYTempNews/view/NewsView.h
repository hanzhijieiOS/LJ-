//
//  NewsView.h
//  知途趣闻
//
//  Created by Jay on 2017/10/25.
//  Copyright © 2017年 hanzhijie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HZJCarouseView;
@class HZJNewsListModel;
@interface NewsView : UITableView

@property (nonatomic, strong) HZJCarouseView *carouseView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSMutableArray *needLoadArray;
@property (nonatomic, assign) BOOL scrollToToping;
- (void)updataDataWithModel:(NSMutableArray *)model;
- (void)loadContent;
@end
