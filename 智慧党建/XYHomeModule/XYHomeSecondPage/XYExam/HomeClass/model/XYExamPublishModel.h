//
//  XYExamPublishModel.h
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/9.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYBaseModel.h"
#import "XYExamInfoModel.h"

@interface XYExamPublishModel : XYBaseModel

@property (nonatomic, copy) NSArray <XYExamInfoModel *> * data;

@end
