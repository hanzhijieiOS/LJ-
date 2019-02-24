//
//  XYPaymentDetailController.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/2/23.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYPaymentDetailController.h"
#import "XYPaymentDetailTopView.h"

@interface XYPaymentDetailController ()

@property (nonatomic, strong) XYPaymentDetailTopView * topView;

@end

@implementation XYPaymentDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topView = [[XYPaymentDetailTopView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 120)];
    [self.view addSubview:self.topView];
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
