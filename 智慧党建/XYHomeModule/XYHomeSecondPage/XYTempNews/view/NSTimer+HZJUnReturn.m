//
//  NSTimer+HZJUnReturn.m
//  知途趣闻
//
//  Created by Jay on 2017/10/26.
//  Copyright © 2017年 hanzhijie. All rights reserved.
//

#import "NSTimer+HZJUnReturn.h"

@implementation NSTimer (HZJUnReturn)

+ (NSTimer *)HZJ_scheduledTimerWithTimerInterval:(NSTimeInterval)interval repeats:(BOOL)repests block:(void (^)(NSTimer *timer))block{
    return [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(HZJ_blockInvoke:) userInfo:[block copy] repeats:repests];
}

+ (void)HZJ_blockInvoke:(NSTimer *)timer{
    void(^block)(NSTimer *timer) = timer.userInfo;
    if (block) {
        block(timer);
    }
}

@end
