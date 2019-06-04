//
//  XYExamDataModel.h
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/9.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYBaseModel.h"
#import "XYExamJudgeModel.h"
#import "XYExamSelectOptionModel.h"

/* 包含一张试卷的全部信息 */

@interface XYExamDataModel : XYBaseModel

@property (nonatomic, assign) NSInteger allScore;

@property (nonatomic, copy) NSString * beginTime;

@property (nonatomic, copy) NSString * createUnit;

@property (nonatomic, copy) NSString * endTime;

@property (nonatomic, copy) NSArray <XYExamJudgeModel *> * examJudgeInfoVos;

@property (nonatomic, assign) NSInteger examJudgeScore;

@property (nonatomic, assign) NSInteger examPaperCount;

@property (nonatomic, copy) NSString * examPaperName;

@property (nonatomic, copy) NSString * examPaperNumber;

@property (nonatomic, assign) NSInteger examPaperType;

@property (nonatomic, copy) NSString * examPaperTypeName;

@property (nonatomic, copy) NSArray <XYExamSelectOptionModel *> * examSelectInfoVos;

@property (nonatomic, assign) NSInteger examSelectScore;

@property (nonatomic, copy) NSString * examStartNum;

@property (nonatomic, copy) NSString * examineeId;

@property (nonatomic, copy) NSString * examineeName;

@end
