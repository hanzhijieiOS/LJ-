//
//  XYNewsListModel.h
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/11.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYBaseModel.h"
#import "XYNewsListItemModel.h"

@interface XYNewsListModel : XYBaseModel

@property (nonatomic, copy) NSArray <XYNewsListItemModel *> * data;

@end
