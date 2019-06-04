//
//  HZJNewsManager.m
//  知途趣闻
//
//  Created by Jay on 2017/10/31.
//  Copyright © 2017年 hanzhijie. All rights reserved.
//

#import "HZJNewsManager.h"
#import "AFNetworking.h"

@implementation HZJNewsManager

static id instance = nil;

+ (instancetype)defaultInstance{
    if (!instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [[[self class] alloc] init];
        });
    }
    return instance;
}

- (void)fetchNewsListWithTyle:(NSString *)type succeed:(HZJNewsHandler)succeedBlock error:(HZJErrorHander)errorBlock{
    NSString *url = [NSString stringWithFormat:@"http://v.juhe.cn/toutiao/index?type=top&key=a89f838a518b5d25515d21894926605f&type=%@",type];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url
      parameters:nil
        progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSError *error;
            HZJNewsModel *model = [[HZJNewsModel alloc] initWithDictionary:responseObject error:&error];
            if (error) {
                errorBlock(error);
            }else if(model.result.data.count){
                succeedBlock(model.result.data);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            errorBlock(error);
        }];
}


- (void)fetchNewsListWithTyle:(NSString *)dtype format:(Boolean)format succeed:(HZJNewsHandler)succeedBlock error:(HZJErrorHander)errorBlock{
    
//    NSString *urlStr = [NSString stringWithFormat:@"http://api.avatardata.cn/ActNews/LookUp?key=ab90d567b6b24ea6acf357ba39e91772&format=true"];
    

}

@end
