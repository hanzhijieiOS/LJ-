//
//  XYLoginItemModel.h
//  智慧党建
//
//  Created by 韩智杰 on 2019/4/29.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYBaseModel.h"

@interface XYLoginItemModel : JSONModel

@property (nonatomic, copy) NSString * joinPartyDate;

@property (nonatomic, copy) NSString * userImg;

@property (nonatomic, assign) long identity;

@property (nonatomic, copy) NSString * nationality;

@property (nonatomic, assign) NSInteger sex;

@property (nonatomic, copy) NSString * identityValue;

@property (nonatomic, copy) NSString * turnPositiveDate;

@property (nonatomic, copy) NSString * fixedTel;

@property (nonatomic, assign) NSInteger permission;

@property (nonatomic, copy) NSString * address;

@property (nonatomic, copy) NSString * birthDay;

@property (nonatomic, copy) NSString * branch;

@property (nonatomic, copy) NSString * idCard;

@property (nonatomic, copy) NSString * tel;

@property (nonatomic, copy) NSString * account;

@property (nonatomic, copy) NSString * email;

@property (nonatomic, copy) NSString * job;

@property (nonatomic, copy) NSString * name;

@end
