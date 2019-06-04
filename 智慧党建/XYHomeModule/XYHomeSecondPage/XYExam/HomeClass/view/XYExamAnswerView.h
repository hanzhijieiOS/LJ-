//
//  XYExamAnswerView.h
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/27.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYExamAnswerView : UIView

+ (CGFloat)getAnswerHeightWithData:(NSArray *)dataArray;

- (void)updateWithData:(NSString *)content select:(BOOL)isSelect;

@end
