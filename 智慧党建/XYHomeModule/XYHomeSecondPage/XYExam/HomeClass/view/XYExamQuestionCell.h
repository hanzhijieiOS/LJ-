//
//  XYExamQuestionCell.h
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/27.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYBaseTableViewCell.h"
#import "XYExamAnswerView.h"
@class XYAnswerModel;

@interface XYExamQuestionCell : XYBaseTableViewCell

+ (instancetype)initWithTableView:(UITableView *)tableView ContentData:(NSObject *)data currentSelectAnswer:(XYAnswerModel *)answer;

@end
