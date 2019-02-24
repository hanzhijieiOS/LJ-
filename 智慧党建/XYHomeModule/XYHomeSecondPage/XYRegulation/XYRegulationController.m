//
//  XYRegulationController.m
//  智慧党建
//
//  Created by jaycehan(韩智杰) on 2019/2/24.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYRegulationController.h"
#import "XYRegulationTopView.h"
#import "XYRegulationTableView.h"

@interface XYRegulationController ()

@property (nonatomic, strong) XYRegulationTopView * topView;
@property (nonatomic, strong) XYRegulationTableView * tableView;

@end

@implementation XYRegulationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topView = [[XYRegulationTopView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    [self.view addSubview:self.topView];
    self.tableView = [[XYRegulationTableView alloc] initWithFrame:CGRectMake(0, 58, self.view.bounds.size.width, self.view.bounds.size.height - 58) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
}

@end
