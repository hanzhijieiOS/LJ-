//
//  XYExamJudgeModel.h
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/6.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYBaseModel.h"

@interface XYExamJudgeModel : JSONModel

@property (nonatomic, copy) NSString * examAnswer;

@property (nonatomic, assign) NSInteger examSubjectType;

@property (nonatomic, copy) NSString * examTittle;

@property (nonatomic, assign) NSInteger score;

@property (nonatomic, copy) NSString * subjectId;

@end
