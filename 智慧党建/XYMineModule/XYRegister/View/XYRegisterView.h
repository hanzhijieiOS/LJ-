//
//  XYRegisterView.h
//  智慧党建
//
//  Created by jaycehan(韩智杰) on 2019/4/9.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XYRegisterViewDelegate <NSObject>

- (void)registerViewSendButtonDidClickWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_BEGIN

@interface XYRegisterView : UIScrollView

@property (nonatomic, weak) id <XYRegisterViewDelegate> sendDelegate;

@end

NS_ASSUME_NONNULL_END
