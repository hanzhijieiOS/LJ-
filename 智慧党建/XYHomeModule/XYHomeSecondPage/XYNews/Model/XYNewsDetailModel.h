//
//  XYNewsDetailModel.h
//  智慧党建
//
//  Created by 韩智杰 on 2019/6/4.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYBaseModel.h"

@interface XYNewsDetailModel : XYBaseModel

@property (nonatomic, copy) NSString * author;

@property (nonatomic, assign) NSInteger belongColumn;

@property (nonatomic, copy) NSString * belongColumnName;

@property (nonatomic, copy) NSString * createAt;

@property (nonatomic, copy) NSString * createUser;

@property (nonatomic, copy) NSString * createUserName;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger informationStatus;

@property (nonatomic, assign) NSInteger isComment;

@property (nonatomic, assign) NSInteger isTop;

@property (nonatomic, copy) NSString * origin;

@property (nonatomic, copy) NSString * summary;

@property (nonatomic, copy) NSString * text;

@property (nonatomic, copy) NSString * tittle;

@property (nonatomic, copy) NSString * columnImg;

@end
