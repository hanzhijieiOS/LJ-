//
//  XYMAnimation.m
//  MobileApp
//
//  Created by Jay on 2017/8/31.
//  Copyright © 2017年 xiyoumobile. All rights reserved.
//

#import "XYMAnimation.h"

@interface XYMAnimation()

@property (nonatomic, strong) NSMutableArray *sequencePositonArray;

@property (nonatomic, strong) NSMutableArray *sequenceViewArray;

@end

@implementation XYMAnimation

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self makeAnimation];
    }
    return self;
}

- (void)makeAnimation{
    self.sequencePositonArray = [NSMutableArray array];
    self.sequenceViewArray = [NSMutableArray array];
    NSArray *colorArray = @[[UIColor blueColor],[UIColor redColor],[UIColor purpleColor],[UIColor yellowColor],[UIColor blueColor],[UIColor blackColor],[UIColor grayColor],[UIColor orangeColor]];
    
    CGFloat centerX = self.center.x;
    CGFloat centerY = self.center.y;
    CGFloat delta = 2*M_PI/8;
    CGFloat x = centerX + 50 * cos(delta*7);
    CGFloat y = centerY + 50 * sin(delta*7);
    
    [self.sequencePositonArray addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    view1.center = self.center;
    view1.backgroundColor = colorArray[0];
    view1.layer.cornerRadius = 5;
    view1.layer.masksToBounds = YES;
    view1.layer.transform = CATransform3DMakeScale(0, 0, 0);
    [self addSubview:view1];
    
    [self.sequenceViewArray addObject:view1];

    for (int i =0; i<7; i++) {
        CGFloat x = centerX + 50 * cos(delta*i);
        CGFloat y = centerY + 50 * sin(delta*i);
        [self.sequencePositonArray addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        view.center = self.center;
        view.backgroundColor = colorArray[i+1];
        view.layer.cornerRadius = 5;
        view.layer.transform = CATransform3DMakeScale(0, 0, 0);
        view.layer.masksToBounds = YES;
        [self addSubview:view];
        [self.sequenceViewArray addObject:view];
    }
}

- (CAAnimationGroup *)createGroupAnimationWithDelay:(CFTimeInterval)time withIndex:(NSInteger)index;
{
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:self.center];
    moveAnimation.toValue = self.sequencePositonArray[index];
    moveAnimation.duration = 0.75;
    moveAnimation.autoreverses = YES;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @(0);
    scaleAnimation.toValue = @(1);
    scaleAnimation.duration = 0.75;
    scaleAnimation.autoreverses = YES;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[moveAnimation,scaleAnimation];
    group.autoreverses = YES;
    group.duration = 0.75;
    group.repeatCount = HUGE_VALF;
    group.beginTime = CACurrentMediaTime()+time;
    return group;
}

- (void)startAnimation{
    for (int i = 0; i<self.sequenceViewArray.count; i++) {
        UIView *view =self.sequenceViewArray[i];
        [view.layer addAnimation:[self createGroupAnimationWithDelay:i*0.1 withIndex:i] forKey:@"group"];
    }
}

- (void)stopAnimation{
    for (UIView * subview in self.sequenceViewArray) {
        [subview.layer removeAllAnimations];
    }
    [self removeFromSuperview];
}

@end
