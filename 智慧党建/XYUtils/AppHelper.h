//
//  AppHelper.h
//  智慧党建
//
//  Created by jaycehan(韩智杰) on 2019/3/10.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppHelper : NSObject
+ (void)ShowHUDPrompt:(NSString *)promptText withParentViewController:(nullable UIViewController *)parentViewController;
@end

NS_ASSUME_NONNULL_END
