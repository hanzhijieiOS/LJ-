//
//  XYBaseTableView.m
//  智慧党建
//
//  Created by 韩智杰 on 2018/12/16.
//  Copyright © 2018年 韩智杰. All rights reserved.
//

#import "XYBaseTableView.h"

@interface XYBaseTableView()<UITableViewDataSource>

@end

@implementation XYBaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.tableFooterView = [UIView new];
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)reloadDataWithData:(id)data{
    
}

@end
