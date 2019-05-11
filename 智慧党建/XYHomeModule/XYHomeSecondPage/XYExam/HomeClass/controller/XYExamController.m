//
//  XYExamController.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/4/27.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYExamController.h"
#import "XYExamTableView.h"
#import "XYExamManager.h"
#import "XYExamInfoModel.h"

@interface XYExamController ()

@property (nonatomic, copy) NSArray <XYExamInfoModel *> * examData;

@property (nonatomic, strong) XYExamTableView * tableView;

@end

@implementation XYExamController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"在线考试";
    self.tableView = [[XYExamTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.examData = [NSMutableArray array];
    [self showLoadingAnimation];
    [self loadData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}


- (void)loadData{
    [[XYExamManager sharedManager] fetchAllPublishExamInfoWithSuccessBlock:^(NSArray<XYExamInfoModel *> *data) {
        self.examData = data;
        [self.tableView updateContentWithData:self.examData];
        [self stopLoadingAnimation];
    } errorBlock:^(NSError *error) {
        [self showEmpty];
        [self stopLoadingAnimation];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
