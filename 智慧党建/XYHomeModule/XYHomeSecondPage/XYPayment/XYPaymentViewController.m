//
//  XYPaymentViewController.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/2/23.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYPaymentViewController.h"
#import "XYPaymentListView.h"

@interface XYPaymentViewController ()

@property (nonatomic, strong) XYPaymentListView * tableView;

@end

@implementation XYPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[XYPaymentListView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self showLoadingAnimation];
}

@end
