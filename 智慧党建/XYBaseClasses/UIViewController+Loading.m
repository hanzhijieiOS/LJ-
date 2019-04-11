//
//  UIViewController+Loading.m
//  智慧党建
//
//  Created by jaycehan(韩智杰) on 2019/4/10.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "UIViewController+Loading.h"
#import "XYAnimationView.h"

@interface UIViewController ()

@property (nonatomic, strong) XYAnimationView * animationView;

@end

@implementation UIViewController (Loading)

- (void)showLoadingAnimation{
    self.animationView = [[XYAnimationView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.animationView];
    [self.animationView start];
}

- (void)stopLoadingAnimation{
    [self.animationView stop];
}

@end
