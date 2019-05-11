//
//  XYNewsTableView.h
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/9.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYBaseTableView.h"
@class XYNewsListItemModel;

@interface XYNewsTableView : XYBaseTableView<UITableViewDelegate, UITableViewDataSource>

- (void)updateContentWithDataList:(NSArray <XYNewsListItemModel *> *)data;

@end
