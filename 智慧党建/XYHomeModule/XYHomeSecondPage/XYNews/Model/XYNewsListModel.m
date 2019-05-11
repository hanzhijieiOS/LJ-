//
//  XYNewsListModel.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/11.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYNewsListModel.h"

@implementation XYNewsListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [XYNewsListItemModel class]};
}

@end
