//
//  XYExamManager.h
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/7.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XYExamPublishModel;
@class XYExamDataModel;
@class XYExamInfoModel;
@class XYBaseModel;
@class XYExamScoreItemModel;

typedef void(^errorBlock)(NSError * error);

typedef void(^XYExamPublishBlock)(NSArray <XYExamInfoModel *> * data);

typedef void(^XYExamBlock)(XYExamDataModel * model);

typedef void(^XYExamSubmitBlock)(void);

typedef void(^XYExamScoreBlock)(XYExamScoreItemModel * model);

typedef void(^XYExamAllScoreBlock)(NSArray <XYExamScoreItemModel *> * model);

@interface XYExamManager : NSObject

+ (id)sharedManager;

- (void)fetchAllPublishExamInfoWithSuccessBlock:(XYExamPublishBlock)successBlock errorBlock:(errorBlock)errorBlock;

- (void)fetchExamInformationWithExamPaperNumber:(NSString *)paperNum;

- (void)fetchExamDetailInformationWithExamPaperNum:(NSString *)paperNum successBlock:(XYExamBlock)successBlock failureBlock:(errorBlock)errorBlock;

- (void)completeExam:(NSString *)examStartNum submitAnswers:(NSArray *)answers success:(XYExamSubmitBlock)successBlock failure:(errorBlock)errorBlock;

- (void)fetchExamScoreWithPaperStartNum:(NSString *)startNum successBlock:(XYExamScoreBlock)successBlock failureBlock:(errorBlock)errorBlock;

- (void)fetchAllExamScoreInfoWithSuccessBlock:(XYExamAllScoreBlock)successBlock failuerBlock:(errorBlock)errorBlock;

@end
