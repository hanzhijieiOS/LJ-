//
//  UIView+Position.h
//  智慧党建
//
//  Created by 韩智杰 on 2018/12/17.
//  Copyright © 2018年 韩智杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Position)

@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat bottom;

@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;

@property(nonatomic) CGPoint origin;
@property(nonatomic) CGSize size;

@property(nonatomic) CGFloat centerX;
@property(nonatomic) CGFloat centerY;

- (void)setOriginY:(CGFloat)originY;

- (void)setOriginX:(CGFloat)originx;


@end
