//
//  HZJResultModel.h
//  知途趣闻
//
//  Created by Jay on 2017/10/31.
//  Copyright © 2017年 hanzhijie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface HZJResultModel : JSONModel

@property (nonatomic, copy) NSString<Optional> *reason;
@property (nonatomic, assign) NSInteger error_code;

@end
