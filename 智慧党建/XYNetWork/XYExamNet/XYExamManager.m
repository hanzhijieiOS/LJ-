//
//  XYExamManager.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/7.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYExamManager.h"
#import "XYExamPublishModel.h"
#import "XYExamDataModel.h"
#import "XYBaseModel.h"
#import "XYExamScoreModel.h"
#import "XYExamAllScoreModel.h"

@implementation XYExamManager

static XYExamManager * instance = nil;

+ (id)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [[[super class] allocWithZone:NULL] init];
        }
    });
    return instance;
}

- (void)fetchAllPublishExamInfoWithSuccessBlock:(XYExamPublishBlock)successBlock errorBlock:(errorBlock)errorBlock{
    NSString * URL = [NSString stringWithFormat:@"http://120.79.14.244:8090/BiShe-web/examPaper/getExamPaper"];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",@"text/javascript", nil];
    [manager GET:URL parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = nil;
        NSError * error;
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        }else{
            dic = (NSDictionary *)responseObject;
        }
        XYExamPublishModel * model = [[XYExamPublishModel alloc] initWithDictionary:dic error:&error];
        
        if (error) {
            errorBlock(error);
        }else{
            successBlock(model.data);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

- (void)fetchExamDetailInformationWithExamPaperNum:(NSString *)paperNum successBlock:(XYExamBlock)successBlock failureBlock:(errorBlock)errorBlock{
//    NSString * URL = [NSString stringWithFormat:@"http://120.79.14.244:8090/BiShe-web/examPaper/startExam?examPaperNum=%@", paperNum];
    NSString * URL = [NSString stringWithFormat:@"http://120.79.14.244:8090/BiShe-web/examPaper/startExam?examPaperNum=%@&examStartNum&page=1&pageSize=50", paperNum];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",@"text/javascript", nil];
    [manager GET:URL parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = nil;
        NSError * error = nil;
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        }else{
            dic = (NSDictionary *)responseObject;
        }
        XYExamDataModel * model = [[XYExamDataModel alloc] initWithDictionary:(NSDictionary *)[dic objectForKey:@"data"] error:&error];
        if (error) {
            errorBlock(error);
        }else{
            successBlock(model);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

- (void)completeExam:(NSString *)examStartNum submitAnswers:(NSArray *)answers success:(XYExamSubmitBlock)successBlock failure:(errorBlock)errorBlock{
    NSString * URL = [NSString stringWithFormat:@"http://120.79.14.244:8090/BiShe-web/examPaper/pageChooseExamSubject"];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",@"text/javascript", nil];
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:examStartNum forKey:@"examStartNum"];
    [param setObject:answers forKey:@"examChooseList"];
    [manager POST:URL parameters:param headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

- (void)fetchExamScoreWithPaperStartNum:(NSString *)startNum successBlock:(XYExamScoreBlock)successBlock failureBlock:(errorBlock)errorBlock{
    NSString * URL = [NSString stringWithFormat:@"http://120.79.14.244:8090/BiShe-web/examPaper/endExam?examStartNum=%@", startNum];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",@"text/javascript", nil];
    
    [manager GET:URL parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError * error = nil;
        XYExamScoreItemModel * model = [[XYExamScoreItemModel alloc] initWithDictionary:responseObject error:&error];
        if (error) {
            errorBlock(error);
        }else{
            successBlock(model);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

- (void)fetchAllExamScoreInfoWithSuccessBlock:(XYExamAllScoreBlock)successBlock failuerBlock:(errorBlock)errorBlock{
    NSString * URL = [NSString stringWithFormat:@"http://120.79.14.244:8090/BiShe-web/examPaper/getAllExamHistory?page=1&pageSize=20"];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",@"text/javascript", nil];
    
    [manager GET:URL parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError * error = nil;
        XYExamAllScoreModel * model = [XYExamAllScoreModel yy_modelWithDictionary:responseObject];
        if (error) {
            errorBlock(error);
        }else{
            NSArray * array = model.data;
            successBlock(array);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

@end
