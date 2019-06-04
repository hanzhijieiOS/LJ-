//
//  XYLoginManager.m
//  智慧党建
//
//  Created by jaycehan(韩智杰) on 2019/3/10.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYLoginManager.h"
#import "XYExamManager.h"

@implementation XYLoginManager

static XYLoginManager * instance = nil;

+ (id)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [[[super class] allocWithZone:NULL] init];
        }
    });
    return instance;
}

- (BOOL)isLogin{
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:XYUserLoginStatus];
    return isLogin;
}

- (void)loginWithAccount:(NSString *)account password:(NSString *)password succeedBlock:(XYLoginBlock)succeedBlock failureBlock:(errorBlock)errorBlock{
    NSString * URL = [NSString stringWithFormat:@"http://120.79.14.244:8090/BiShe-web/userCenter/login"];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:account forKey:@"tel"];
    [params setObject:password forKey:@"password"];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",@"text/javascript", nil];
    [manager POST:URL parameters:params headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSError * error;
            NSDictionary * dic;
            if (![responseObject isKindOfClass:[NSDictionary class]]) {
                dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            }else{
                dic = (NSDictionary *)responseObject;
            }
            if (error) {
                errorBlock(error);
            }else{
                XYLoginModel * model = [[XYLoginModel alloc] initWithDictionary:dic error:&error];
                if (error) {
                    errorBlock(error);
                }else{
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:XYUserLoginStatus];
                    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model.data];
                    [[NSUserDefaults standardUserDefaults] setObject:data forKey:XYCurrentUserInfo];
                    
                    NSMutableDictionary * userDic = [NSMutableDictionary dictionary];
                    [userDic setObject:account forKey:XYCurrentUsername];
                    [userDic setObject:password forKey:XYCurrentUserPassword];
                    [[NSUserDefaults standardUserDefaults] setObject:userDic forKey:XYCurrentUserAccount];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    succeedBlock(model);
                    [[NSNotificationCenter defaultCenter] postNotificationName:XYUserLoginStatusDidChangeNotification object:nil];
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

- (void)registerWithTel:(NSString *)tel Password:(NSString *)password Email:(NSString *)email Name:(NSString *)name Birthday:(NSString *)birthday Sex:(NSString *)sex succeed:(XYRegisterBlock)succeedBlock failureBlock:(errorBlock)errorBlock{
    NSString * URL = [NSString stringWithFormat:@"http://120.79.14.244:8090/BiShe-web/userCenter/register"];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    if (tel.length) {
        [dic setObject:tel forKey:@"tel"];
    }
    if (email.length) {
        [dic setObject:email forKey:@"email"];
    }
    if (birthday.length) {
        [dic setObject:birthday forKey:@"birthDay"];
    }
    [dic setObject:name forKey:@"name"];
    [dic setObject:password forKey:@"password"];
//    [dic setObject:sex forKey:@"sex"];
    
    AFHTTPSessionManager * mng = [AFHTTPSessionManager manager];
    mng.requestSerializer=[AFJSONRequestSerializer serializer];
    mng.responseSerializer = [AFJSONResponseSerializer serializer];
    mng.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",@"text/javascript", nil];
    [mng POST:URL parameters:dic headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSError * error;
            NSDictionary * dic;
            if (![responseObject isKindOfClass:[NSDictionary class]]) {
                dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            }else{
                dic = (NSDictionary *)responseObject;
            }
            if (error) {
                errorBlock(error);
            }else{
//                XYLoginModel * model = [[XYLoginModel alloc] initWithDictionary:dic error:&error];
                XYLoginModel * model = [XYLoginModel yy_modelWithDictionary:dic];
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
