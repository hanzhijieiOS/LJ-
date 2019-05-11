//
//  XYExamTableView.h
//  智慧党建
//
//  Created by 韩智杰 on 2019/4/27.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYBaseTableView.h"
@class XYExamInfoModel;

@interface XYExamTableView : XYBaseTableView<UITableViewDataSource, UITableViewDelegate>

- (void)updateContentWithData:(NSArray <XYExamInfoModel *> *)data;

@end
