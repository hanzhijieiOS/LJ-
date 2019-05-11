//
//  XYBaseModel.h
//  智慧党建
//
//  Created by jaycehan(韩智杰) on 2019/3/10.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYBaseModel : JSONModel

@property (nonatomic, copy) NSString * message;

@property (nonatomic, assign) long errcode;

@end

NS_ASSUME_NONNULL_END
