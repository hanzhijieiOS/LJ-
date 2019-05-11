//
//  XYExamView.h
//  智慧党建
//
//  Created by 韩智杰 on 2019/4/27.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYExamListCell;

@interface XYExamView : UIView

@property (nonatomic, assign) BOOL isSelected;

- (void)setAnswerLabelTitle:(NSString *)title;

- (void)setButtonStatusToBeSelected;

- (void)cancelButtonStatusSelected;

- (NSString *)getAnswerLabeltext;

+ (CGFloat)questionAnswerCell:(XYExamListCell *)questionAnswerCell rowHeightForObject:(id)object;
@end
