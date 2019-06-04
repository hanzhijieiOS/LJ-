//
//  XYExamSelectModel.h
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/6.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYBaseModel.h"
#import "XYExamSelectInfoModel.h"
#import "XYExamSelectOptionModel.h"

/* 包含某个选择题的全部信息 */

@interface XYExamSelectModel : XYBaseModel

@property (nonatomic, copy) NSString * examAnswer;

@property (nonatomic, assign) long examMiddleType;

@property (nonatomic, copy) NSString * examMiddleTypeName;

@property (nonatomic, assign) long examSubjectType;

@property (nonatomic, copy) NSString * examParse;

@property (nonatomic, copy) NSString * examTittle;

@property (nonatomic, copy) NSString * myAnswer;

@property (nonatomic, assign) NSInteger score;

@property (nonatomic, copy) NSArray <XYExamSelectInfoModel *> * selectOptionInfos;

@property (nonatomic, copy) NSString * subjectId;

@end
