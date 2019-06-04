//
//  XYTabBarController+JLRoutes.m
//  智慧党建
//
//  Created by 韩智杰 on 2018/12/17.
//  Copyright © 2018年 韩智杰. All rights reserved.
//

#import "XYTabBarController+JLRoutes.h"
#import "XYNavigationController.h"
#import <objc/runtime.h>

@implementation XYTabBarController (JLRoutes)

- (void)registerRoute{
    NSArray * childVC = [self viewControllers];
    if (childVC.count < 3) {
        return;
    }
    [self registerRouteWithHome:childVC[0]];
//    [self registerRouteWithMessage:childVC[1]];
//    [self registerRouteWithFind:childVC[2]];
    [self registerRouteWithMine:childVC[2]];
}

- (void)registerRouteWithHome:(XYNavigationController *)navigation{
    [[JLRoutes routesForScheme:@"XYHome"] addRoute:@"/Home/:ViewController" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        Class class = NSClassFromString(parameters[@"ViewController"]);
        XYBaseViewController * nextVC = [[class alloc] init];
        [self sendParam:parameters toViewController:nextVC];
        XYSwitchScheme scheme = [parameters[@"Scheme"] integerValue];
        if (scheme == XYSwitchPush) {
            [navigation pushViewController:nextVC animated:YES];
        }else if(scheme == XYSwitchPresent){
            [[XYUtils getTopViewController] presentViewController:nextVC animated:YES completion:nil];
        }else{
            
        }
        self.selectedIndex = 0;
        return YES;
    }];
}

- (void)registerRouteWithMessage:(XYNavigationController *)navigation{
    [[JLRoutes routesForScheme:@"XYMessage"] addRoute:@"/Message/:ViewController" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        Class class = NSClassFromString(parameters[@"ViewController"]);
        XYBaseViewController * nextVC = [[class alloc] init];
        [self sendParam:parameters toViewController:nextVC];
        XYSwitchScheme scheme = [parameters[@"Scheme"] integerValue];
        if (scheme == XYSwitchPush) {
            [navigation pushViewController:nextVC animated:YES];
        }else if(scheme == XYSwitchPresent){
            [[XYUtils getTopViewController] presentViewController:nextVC animated:YES completion:nil];
        }else{
            
        }
//        self.selectedIndex = 1;
        return YES;
    }];
}

- (void)registerRouteWithFind:(XYNavigationController *)navigation{
    [[JLRoutes routesForScheme:@"XYFind"] addRoute:@"/Find/:ViewController" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        Class class = NSClassFromString(parameters[@"ViewController"]);
        XYBaseViewController * nextVC = [[class alloc] init];
        [self sendParam:parameters toViewController:nextVC];
        XYSwitchScheme scheme = [parameters[@"Scheme"] integerValue];
        if (scheme == XYSwitchPush) {
            [navigation pushViewController:nextVC animated:YES];
        }else if(scheme == XYSwitchPresent){
            [[XYUtils getTopViewController] presentViewController:nextVC animated:YES completion:nil];
        }else{
            
        }
//        self.selectedIndex = 2;
        return YES;
    }];
}

- (void)registerRouteWithMine:(XYNavigationController *)navigation{
    [[JLRoutes routesForScheme:@"XYMine"] addRoute:@"/Mine/:ViewController" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        Class class = NSClassFromString(parameters[@"ViewController"]);
        XYBaseViewController * nextVC = [[class alloc] init];
        [self sendParam:parameters toViewController:nextVC];
        XYSwitchScheme scheme = [parameters[@"Scheme"] integerValue];
        if (scheme == XYSwitchPush) {
            [navigation pushViewController:nextVC animated:YES];
        }else if(scheme == XYSwitchPresent){
            if (!nextVC.navigationController) {
                XYNavigationController * naviVC = [[XYNavigationController alloc] initWithRootViewController:nextVC];
                [naviVC configNavigationBar];
                [[XYUtils getTopViewController] presentViewController:naviVC animated:YES completion:nil];
            }else{
                [[XYUtils getTopViewController] presentViewController:nextVC.navigationController animated:YES completion:nil];
            }
        }else{
            if (![XYUtils getTopViewController].navigationController) {
                XYNavigationController * naviVC = [[XYNavigationController alloc] initWithRootViewController:[XYUtils getTopViewController]];
                [naviVC pushViewController:nextVC animated:YES];
            }else{
                [[XYUtils getTopViewController].navigationController pushViewController:nextVC animated:YES];
            }
        }
//        self.selectedIndex = 2; //3
        return YES;
    }];
}

- (void)sendParam:(NSDictionary<NSString *, NSString *>*)param toViewController:(XYBaseViewController *)viewController{
    unsigned int count = 0;
    objc_property_t * propertyList = class_copyPropertyList([viewController class], &count);
    for (int i = 0; i < count; i ++) {
        objc_property_t property = propertyList[i];
        NSString * key = [NSString stringWithUTF8String:property_getName(property)];
        NSString * value = param[key];
        if (value != nil) {
            [viewController setValue:value forKey:key];
        }
    }
}

@end
