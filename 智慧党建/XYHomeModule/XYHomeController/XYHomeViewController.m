//
//  XYHomeViewController.m
//  智慧党建
//
//  Created by 韩智杰 on 2018/12/17.
//  Copyright © 2018年 韩智杰. All rights reserved.
//

#import "XYHomeViewController.h"
#import "XYHomeTableView.h"

@interface XYHomeViewController ()

@property (nonatomic, strong) XYHomeTableView * tableView;

@end

@implementation XYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    self.tableView = [[XYHomeTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
