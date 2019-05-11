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

@interface XYExamSelectModel : XYBaseModel

@property (nonatomic, assign) NSInteger * examInfoType;

@property (nonatomic, copy) NSString * examAnswer;

@property (nonatomic, copy) NSString * examParse;

@property (nonatomic, copy) NSString * examTittle;

@property (nonatomic, assign) NSInteger score;

@property (nonatomic, assign) NSInteger examSelectScore;

@property (nonatomic, copy) NSString * examStartNum;

@property (nonatomic, copy) NSString * examineeId;

@property (nonatomic, copy) NSString * examineeName;

@property (nonatomic, copy) NSArray <XYExamSelectOptionModel *> * examSelectInfoVos;

@end
