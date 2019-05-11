//
//  XYExamHistoryTableView.h
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/11.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYBaseTableView.h"
@class XYExamScoreItemModel;

@interface XYExamHistoryTableView : XYBaseTableView<UITableViewDataSource, UITableViewDelegate>

- (void)updateContentWithData:(NSArray <XYExamScoreItemModel *> *)data;
@end
