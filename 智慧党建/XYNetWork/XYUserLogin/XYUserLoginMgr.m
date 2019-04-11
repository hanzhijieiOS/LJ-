//
//  XYUserLoginMgr.m
//  智慧党建
//
//  Created by jaycehan(韩智杰) on 2019/4/10.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYUserLoginMgr.h"

@implementation XYUserLoginMgr

static XYUserLoginMgr * instance = nil;

+ (id)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [[[super class] allocWithZone:NULL] init];
        }
    });
    return instance;
}

- (BOOL)isLoggedIn{
    BOOL loggedIn = [[NSUserDefaults standardUserDefaults] boolForKey:XYUserLoginStatus];
    return loggedIn;
}



@end
