//
//  XYExamScoreItemModel.h
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/10.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYBaseModel.h"

@interface XYExamScoreItemModel : JSONModel

@property (nonatomic, assign) NSInteger allScore;

@property (nonatomic, copy) NSString * beginTime;

@property (nonatomic, copy) NSString * endTime;

@property (nonatomic, copy) NSString * examPaperNum;

@property (nonatomic, copy) NSString * examStartNum;

@property (nonatomic, copy) NSString * examinee;

@property (nonatomic, assign) NSInteger score;

@end
