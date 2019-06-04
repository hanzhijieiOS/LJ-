//
//  HZJNewsModel.h
//  知途趣闻
//
//  Created by Jay on 2017/10/26.
//  Copyright © 2017年 hanzhijie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "HZJResultModel.h"

@protocol HZJNewsItemModel
@end
@protocol HZJNewsListModel
@end

@interface HZJNewsItemModel : JSONModel

@property (nonatomic, copy) NSString *author_name;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *thumbnail_pic_s;
@property (nonatomic, copy) NSString<Optional> *thumbnail_pic_s02;
@property (nonatomic, copy) NSString<Optional> *thumbnail_pic_s03;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *uniquekey;
@property (nonatomic, copy) NSString *url;

@end

@interface HZJNewsListModel : JSONModel

@property (nonatomic, copy) NSString *stat;

@property (nonatomic, strong) NSMutableArray<HZJNewsItemModel> *data;

@end

@interface HZJNewsModel : HZJResultModel

@property (nonatomic, strong) HZJNewsListModel *result;

@end
