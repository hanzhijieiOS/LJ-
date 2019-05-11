//
//  XYNewsAllItemsModel.h
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/11.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYBaseModel.h"
#import "XYNewsItemModel.h"

@protocol XYNewsItemModel;

@interface XYNewsAllItemsModel : XYBaseModel

@property (nonatomic, strong) NSArray <XYNewsItemModel *> * data;

@end
