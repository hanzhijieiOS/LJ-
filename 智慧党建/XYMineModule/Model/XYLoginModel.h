//
//  XYLoginModel.h
//  智慧党建
//
//  Created by jaycehan(韩智杰) on 2019/3/10.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYBaseModel.h"
#import "XYLoginItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYLoginModel : XYBaseModel

@property (nonatomic, strong) XYLoginItemModel * data;

@end

NS_ASSUME_NONNULL_END
