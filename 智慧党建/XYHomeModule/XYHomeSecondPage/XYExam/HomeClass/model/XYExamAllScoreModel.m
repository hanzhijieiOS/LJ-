//
//  XYExamAllScoreModel.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/11.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYExamAllScoreModel.h"

@implementation XYExamAllScoreModel

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [XYExamScoreItemModel class]};
}

@end
