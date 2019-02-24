//
//  XYTabBarController.m
//  智慧党建
//
//  Created by 韩智杰 on 2018/12/16.
//  Copyright © 2018年 韩智杰. All rights reserved.
//

#import "XYTabBarController.h"
#import "XYHomeViewController.h"
#import "XYMessageViewController.h"
#import "XYFindViewController.h"
#import "XYMineViewController.h"
#import "XYNavigationController.h"
#import "XYTabBarController+JLRoutes.h"

@interface XYTabBarController ()

@end

@implementation XYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.tabBar setBackgroundImage:[XYUtils imageWithColor:[UIColor redColor]]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSubViewController{
    XYHomeViewController * homeVC = [[XYHomeViewController alloc] init];
    XYNavigationController * homeNavi = [[XYNavigationController alloc] initWithRootViewController:homeVC];
    homeNavi.tabBarItem.image = [UIImage imageNamed:@"tb_home.png"];
    UIImage *imageHome = [UIImage imageNamed:@"tb_home_s.png"];
    imageHome = [imageHome imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [homeNavi.tabBarItem setSelectedImage:imageHome];
    homeNavi.tabBarItem.title = @"主页";
    NSDictionary *dictHome = [NSDictionary dictionaryWithObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    [homeNavi.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
    
    
    XYMessageViewController * msgVC = [[XYMessageViewController alloc] init];
    XYNavigationController * msgNavi = [[XYNavigationController alloc] initWithRootViewController:msgVC];
    msgNavi.tabBarItem.image = [UIImage imageNamed:@"tb_message.png"];
    UIImage *imageMsg = [UIImage imageNamed:@"tb_message_s.png"];
    imageMsg = [imageMsg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [msgNavi.tabBarItem setSelectedImage:imageMsg];
    msgNavi.tabBarItem.title = @"消息";
    NSDictionary *dictMsg = [NSDictionary dictionaryWithObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    [msgNavi.tabBarItem setTitleTextAttributes:dictMsg forState:UIControlStateSelected];
    
    
    XYFindViewController * findVC = [[XYFindViewController alloc] init];
    XYNavigationController * findNavi = [[XYNavigationController alloc] initWithRootViewController:findVC];
    findNavi.tabBarItem.image = [UIImage imageNamed:@"tb_find.png"];
    UIImage *imageFind = [UIImage imageNamed:@"tb_find_s.png"];
    imageFind = [imageFind imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [findNavi.tabBarItem setSelectedImage:imageFind];
    findNavi.tabBarItem.title = @"发现";
    NSDictionary *dictFine = [NSDictionary dictionaryWithObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    [findNavi.tabBarItem setTitleTextAttributes:dictFine forState:UIControlStateSelected];
    
    
    XYMineViewController * mineVC = [[XYMineViewController alloc] init];
    XYNavigationController * mineNavi = [[XYNavigationController alloc] initWithRootViewController:mineVC];
    mineNavi.tabBarItem.image = [UIImage imageNamed:@"tb_mine.png"];
    UIImage *imageMine = [UIImage imageNamed:@"tb_mine_s.png"];
    imageMine = [imageMine imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [mineNavi.tabBarItem setSelectedImage:imageMine];
    mineNavi.tabBarItem.title = @"我的";
    NSDictionary *dictMine = [NSDictionary dictionaryWithObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    [mineNavi.tabBarItem setTitleTextAttributes:dictMine forState:UIControlStateSelected];
    
    
    self.viewControllers = @[homeNavi, msgNavi, findNavi, mineNavi];
    [self registerRoute];
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
