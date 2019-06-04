//
//  XYInfomationController.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/28.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYInfomationController.h"
#import "XYInfoTableView.h"

@interface XYInfomationController ()

@property (nonatomic, strong) XYInfoTableView * tableView;

@end

@implementation XYInfomationController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.tableView = [[XYInfoTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
}

@end
