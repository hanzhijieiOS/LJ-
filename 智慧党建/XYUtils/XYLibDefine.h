//
//  XYLibDefine.h
//  智慧党建
//
//  Created by 韩智杰 on 2018/12/17.
//  Copyright © 2018年 韩智杰. All rights reserved.
//

#ifndef XYLibDefine_h
#define XYLibDefine_h

#import <Foundation/Foundation.h>

#define KScreenHeight [UIScreen mainScreen].bounds.size.height
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KEdgeSpacing 12

typedef NS_ENUM(NSUInteger, XYSwitchScheme) {
    XYSwitchPush = 0,
    XYSwitchPresent,
    XYSwitchUnknow
};

#endif /* XYLibDefine_h */
