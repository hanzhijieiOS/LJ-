//
//  XYNewsListItemModel.h
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/11.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYNewsListItemModel : NSObject

@property (nonatomic, copy) NSString * columnName;

@property (nonatomic, assign) long columnStatus;

@property (nonatomic, copy) NSString * createTime;

@property (nonatomic, copy) NSString * createUserId;

@property (nonatomic, copy) NSString * createUserName;

@property (nonatomic, assign) long id;

@property (nonatomic, assign) long isReview;

@property (nonatomic, copy) NSString * parentId;

@property (nonatomic, copy) NSString * parentName;

@property (nonatomic, copy) NSString * reviewUserId;

@property (nonatomic, copy) NSString * reviewUserName;

@property (nonatomic, assign) long total;

@end
