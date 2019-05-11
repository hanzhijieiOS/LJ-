//
//  ZTHDataSourceManager.h
//  ZTHSubjectCell
//
//  Created by 9188 on 2017/3/15.
//  Copyright © 2018年 韩智杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYExamDataModel.h"

@interface ZTHDataSourceManager : NSObject

@property (nonatomic, copy, readonly) NSArray *questions;

- (instancetype)initWithExamData:(XYExamDataModel *)dataModel;

@end
