//
//  AppHelper.m
//  智慧党建
//
//  Created by jaycehan(韩智杰) on 2019/3/10.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "AppHelper.h"

@implementation AppHelper

+ (void)ShowHUDPrompt:(NSString *)promptText withParentViewController:(UIViewController *)parentViewController
{
    UIView * view = parentViewController.view;
    if (!view) {
        view = [XYUtils getTopViewController].view;
    }
    MBProgressHUD * hub = [[MBProgressHUD alloc] init];
    [view addSubview:hub];
    hub.mode = MBProgressHUDModeText;
    hub.label.text = promptText;
    hub.backgroundColor = [UIColor clearColor];
    hub.label.textColor = [UIColor whiteColor];
    hub.bezelView.color = [UIColor blackColor];
    hub.opaque = 1;
    [hub showAnimated:YES];
    [hub hideAnimated:YES afterDelay:1.6];
}

+ (void)ShowHUDPrompt:(NSString *)promptText{
    UIView * view = [XYUtils getTopViewController].view;
    MBProgressHUD * hub = [[MBProgressHUD alloc] init];
    [view addSubview:hub];
    hub.mode = MBProgressHUDModeText;
    hub.label.text = promptText;
    hub.backgroundColor = [UIColor clearColor];
    hub.label.textColor = [UIColor whiteColor];
    hub.bezelView.color = [UIColor blackColor];
    hub.opaque = 1;
    [hub showAnimated:YES];
}

+ (void)DismissHUDPromptWithText:(NSString *)promptText{
    
}

@end
