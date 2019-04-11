//
//  XYUserLoginMgr.h
//  智慧党建
//
//  Created by jaycehan(韩智杰) on 2019/4/10.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYUserLoginMgr : NSObject

+ (id)sharedInstance;

- (BOOL)isLoggedIn;

@end

NS_ASSUME_NONNULL_END
