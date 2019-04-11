//
//  XYAnimationView.h
//  智慧党建
//
//  Created by jaycehan(韩智杰) on 2019/4/10.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYAnimationView : UIView

-(void)start;
-(void)stop;

+(void)showInView:(UIView*)view;

+(void)hideInView:(UIView*)view;

@end

NS_ASSUME_NONNULL_END
