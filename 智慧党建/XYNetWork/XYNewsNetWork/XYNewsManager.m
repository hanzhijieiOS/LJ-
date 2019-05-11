//
//  XYNewsManager.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/9.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYNewsManager.h"
#import "XYNewsAllItemsModel.h"
#import "XYNewsListModel.h"

@implementation XYNewsManager

static XYNewsManager * instance = nil;

+ (id)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [[[super class] allocWithZone:NULL] init];
        }
    });
    return instance;
}

- (void)fetchAllNewsItemWithSuccessBlock:(XYNewsItemHandler)successBlock errorBlock:(XYErrorHandler)errorBlock{
    NSString * URL = [NSString stringWithFormat:@"http://120.79.14.244:8090/BiShe-web/admin/columnManage/getAllParentColumn"];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",@"text/javascript", nil];
    [manager GET:URL parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        XYNewsAllItemsModel * model = [XYNewsAllItemsModel yy_modelWithDictionary:responseObject];
        if (model) {
            successBlock(model.data);
        }else{
            errorBlock(nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

- (void)fetchNewsListWithColumnId:(NSInteger)columnId successBlock:(XYNewsListHandler)successBlock failureBlock:(XYErrorHandler)errorBlock{
    NSString * URL = [NSString stringWithFormat:@" http://120.79.14.244:8090/BiShe-web/columnManage/getColumnByParent?columnId=%ld", (long)columnId];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",@"text/javascript", nil];
    [manager GET:URL parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        XYNewsListModel * model = [XYNewsListModel yy_modelWithDictionary:responseObject];
        if (model) {
            successBlock(model.data);
        }else{
            errorBlock(nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}
@end
