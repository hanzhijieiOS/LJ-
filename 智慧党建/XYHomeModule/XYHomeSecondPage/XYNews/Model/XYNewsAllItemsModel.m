//
//  XYNewsAllItemsModel.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/11.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYNewsAllItemsModel.h"
#import "XYNewsItemModel.h"

@implementation XYNewsAllItemsModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [XYNewsItemModel class]};
}

@end
