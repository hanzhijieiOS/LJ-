//
//  XYMineViewController.m
//  智慧党建
//
//  Created by 韩智杰 on 2018/12/17.
//  Copyright © 2018年 韩智杰. All rights reserved.
//

#import "XYMineViewController.h"
#import "XYMineTableView.h"

@interface XYMineViewController ()

@property (nonatomic, strong) XYMineTableView * tableView;

@end

@implementation XYMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[XYMineTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
