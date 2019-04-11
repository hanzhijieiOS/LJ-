//
//  XYPaymentDetailController.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/2/23.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYPaymentDetailController.h"
#import "XYPaymentDetailTopView.h"
#import "XYPaymentDetailBottomView.h"
#import "XYPayChannelTableView.h"

@interface XYPaymentDetailController ()

@property (nonatomic, strong) XYPaymentDetailTopView * topView;
@property (nonatomic, strong) XYPayChannelTableView * tableView;
@property (nonatomic, strong) XYPaymentDetailBottomView * bottomView;

@end

@implementation XYPaymentDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    
}

- (XYPaymentDetailTopView *)topView{
    if (!_topView) {
        _topView = [[XYPaymentDetailTopView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 120)];
    }
    return _topView;
}

- (XYPaymentDetailBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[XYPaymentDetailBottomView alloc] initWithFrame:CGRectMake(0, self.view.height - HEIGHT_NAVIGATIONBAR_AND_STATUSBAR - 44 - kSafeAreaBottomPaddingHeight, self.view.width, 44 + kSafeAreaBottomPaddingHeight)];
        [_bottomView setPaymentText:@"确认支付"];
    }
    return _bottomView;
}

- (XYPayChannelTableView *)tableView{
    if (!_tableView) {
        _tableView = [[XYPayChannelTableView alloc] initWithFrame:CGRectMake(0, self.topView.bottom + 8, self.view.width, self.bottomView.top - self.topView.bottom) style:UITableViewStylePlain];
    }
    return _tableView;
}

@end
