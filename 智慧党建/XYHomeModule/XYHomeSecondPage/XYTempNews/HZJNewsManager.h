//
//  HZJNewsManager.h
//  知途趣闻
//
//  Created by Jay on 2017/10/31.
//  Copyright © 2017年 hanzhijie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZJNewsModel.h"

typedef void(^HZJNewsHandler)(NSMutableArray<HZJNewsItemModel> * __nonnull newsList);

typedef void(^HZJErrorHander)(NSError * _Nullable error);

@interface HZJNewsManager : NSObject

+ (instancetype)defaultInstance;

- (void)fetchNewsListWithTyle:(NSString *_Nullable)type
                      succeed:(HZJNewsHandler _Nullable )succeedBlock
                        error:(HZJErrorHander _Nullable )errorBlock;

- (void)searchNewsWithkeyWord:(NSString *_Nullable)keyword
                         type:(NSString *_Nullable)dtype
                       format:(Boolean)format;
@end
