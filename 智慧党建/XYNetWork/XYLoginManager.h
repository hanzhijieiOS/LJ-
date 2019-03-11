//
//  XYLoginManager.h
//  智慧党建
//
//  Created by jaycehan(韩智杰) on 2019/3/10.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYLoginModel.h"
#import "XYRegisterModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^errorBlock)(NSError * error);

typedef void(^XYRegisterBlock)(XYRegisterModel * model);

typedef void(^XYLoginBlock)(XYLoginModel * model);

@interface XYLoginManager : NSObject

- (id)sharedManager;

- (instancetype)init __attribute__((unavailable("Should use sharedManager")));

+ (void)loginWithTel:(NSString *)tel Password:(NSString *)password succeedBlock:(XYLoginBlock)succeedBlock failureBlock:(errorBlock)errorBlock;

+ (void)registerWithTel:(NSString *)tel Password:(NSString *)password Email:(NSString *)email Name:(NSString *)name Birthday:(NSString *)birthday Sex:(NSString *)sex succeed:(XYRegisterBlock)succeedBlock failureBlock:(errorBlock)errorBlock;

@end

NS_ASSUME_NONNULL_END
