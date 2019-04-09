//
//  XYNavigationController.m
//  智慧党建
//
//  Created by 韩智杰 on 2018/12/16.
//  Copyright © 2018年 韩智杰. All rights reserved.
//

#import "XYNavigationController.h"

@interface XYNavigationController ()

@property (nonatomic, strong) UIButton * backButton;

@end

@implementation XYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBackgroundImage:[XYUtils imageWithColor:[UIColor redColor]] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.barStyle = UIStatusBarStyleLightContent;
    [self setNeedsStatusBarAppearanceUpdate];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count == 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)configNavigationBar{
    [self.navigationBar setBackgroundImage:[XYUtils imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.barStyle = UIStatusBarStyleDefault;
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(12, (self.navigationBar.height - 25) / 2.0, 25, 25)];
    self.backButton.backgroundColor = [UIColor clearColor];
    [self.backButton setImage:[UIImage imageNamed:@"cha.png"] forState:UIControlStateNormal];
    [self.navigationBar addSubview:self.backButton];
    [self.backButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dismiss{
    if (self.viewControllers.count > 1) {
        [self popViewControllerAnimated:YES];
    }else if(self.viewControllers.count == 1){
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
    }
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
