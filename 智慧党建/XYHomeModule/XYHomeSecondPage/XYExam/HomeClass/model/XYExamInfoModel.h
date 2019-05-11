//
//  XYExamInfoModel.h
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/7.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYBaseModel.h"

@interface XYExamInfoModel : JSONModel

@property (nonatomic, copy) NSString * createUnit;

@property (nonatomic, copy) NSString * examPaperName;

@property (nonatomic, copy) NSString * examPaperNum;

@property (nonatomic, assign) long examPaperType;

@property (nonatomic, copy) NSString * invalidTime;

@property (nonatomic, copy) NSString * responsible;

@property (nonatomic, assign) long status;

@property (nonatomic, assign) long examPaperStatus;

@end
