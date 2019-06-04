//
//  NSTimer+HZJUnReturn.h
//  知途趣闻
//
//  Created by Jay on 2017/10/26.
//  Copyright © 2017年 hanzhijie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (HZJUnReturn)

+ (NSTimer *)HZJ_scheduledTimerWithTimerInterval:(NSTimeInterval)interval repeats:(BOOL)repests block:(void(^)(NSTimer *))block;

@end
