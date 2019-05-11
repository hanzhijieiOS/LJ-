//
//  XYError.h
//  MobileApp
//
//  Created by dengtuotuo on 2017/7/11.
//  Copyright © 2017年 xiyoumobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYMError : NSObject

/**
 *  错误码
 */
@property (nonatomic) NSInteger code;
/**
 *  错误信息描述
 */
@property (nonatomic,copy)NSString *msg;

/**
 *  根据参数初始化实例
 *
 *  @param code 错误码
 *  @param msg  错误信息描述
 *
 *  @return 实例
 */
- (instancetype)initWithErrorCode:(NSInteger)code msg:(NSString*)msg;

+ (instancetype)errorWithSystemNSError:(NSError*)error;


@end
