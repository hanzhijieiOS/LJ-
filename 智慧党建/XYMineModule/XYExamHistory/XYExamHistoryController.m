//
//  XYExamHistoryController.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/11.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYExamHistoryController.h"
#import "XYExamHistoryTableView.h"
#import "XYExamManager.h"
#import "XYExamScoreItemModel.h"

@interface XYExamHistoryController ()

@property (nonatomic, strong) XYExamHistoryTableView * tableView;

@end

@implementation XYExamHistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"历史成绩";
    self.tableView = [[XYExamHistoryTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    [self showLoadingAnimation];
    [self reloadData];
    
}

- (void)reloadData{
    [[XYExamManager sharedManager] fetchAllExamScoreInfoWithSuccessBlock:^(NSArray<XYExamScoreItemModel *> *model) {
        [self stopLoadingAnimation];
        [self.tableView updateContentWithData:model];
    } failuerBlock:^(NSError *error) {
        [self stopLoadingAnimation];
        [self showEmpty];
    }];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
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
