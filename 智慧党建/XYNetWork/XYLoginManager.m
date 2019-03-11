//
//  XYLoginManager.m
//  智慧党建
//
//  Created by jaycehan(韩智杰) on 2019/3/10.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYLoginManager.h"

@implementation XYLoginManager

static XYLoginManager * instance = nil;

- (id)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [[[super class] allocWithZone:NULL] init];
        }
    });
    return instance;
}

+ (void)loginWithTel:(NSString *)tel Password:(NSString *)password succeedBlock:(XYLoginBlock)succeedBlock failureBlock:(errorBlock)errorBlock{
    NSString * URLStr = [NSString stringWithFormat:@"http://120.79.14.244/userCenter/login?tel=%@&password=%@",tel,password];
    AFHTTPSessionManager * mng = [AFHTTPSessionManager manager];
    mng.requestSerializer.timeoutInterval = 30.f;
    [mng GET:URLStr parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSError * error;
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            if (error) {
                errorBlock(error);
            }else{
                XYLoginModel * model = [[XYLoginModel alloc] initWithDictionary:dic error:&error];
                if (error) {
                    errorBlock(error);
                }else{
                    succeedBlock(model);
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

+ (void)registerWithTel:(NSString *)tel Password:(NSString *)password Email:(NSString *)email Name:(NSString *)name Birthday:(NSString *)birthday Sex:(NSString *)sex succeed:(XYRegisterBlock)succeedBlock failureBlock:(errorBlock)errorBlock{
    NSString * URL = [NSString stringWithFormat:@"http://120.79.14.244/userCenter/register?tel=%@&password=%@&permission=0&email=%@&name=%@&birthday=%@&sex=%@",tel, password, email, name, birthday, sex];
    [[AFHTTPSessionManager manager] GET:URL parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSError * error;
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            if (error) {
                errorBlock(error);
            }else{
                XYRegisterModel * model = [[XYRegisterModel alloc] initWithDictionary:dic error:&error];
                if (error) {
                    errorBlock(error);
                }else{
                    succeedBlock(model);
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

@end
