//
//  XYNewsManager.h
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/9.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XYNewsAllItemsModel;
@class XYNewsItemModel;
@class XYNewsListItemModel;

typedef void(^XYErrorHandler)(NSError * __nullable error);

typedef void(^XYNewsItemHandler)(NSArray <XYNewsItemModel *> * data);

typedef void(^XYNewsListHandler)(NSArray <XYNewsListItemModel *> * data);

@interface XYNewsManager : NSObject

+ (id)sharedManager;

- (void)fetchAllNewsItemWithSuccessBlock:(XYNewsItemHandler)successBlock errorBlock:(XYErrorHandler)errorBlock;

- (void)fetchNewsListWithColumnId:(NSInteger)columnId successBlock:(XYNewsListHandler)successBlock failureBlock:(XYErrorHandler)errorBlock;

@end
