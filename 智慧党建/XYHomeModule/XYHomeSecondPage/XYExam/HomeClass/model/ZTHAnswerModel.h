//
//  SCYCreditLoginAnswerModel.h
//  ProvidentFund
//
//  Created by 9188 on 16/9/18.
//  Copyright © 2016年 9188. All rights reserved.
//  征信登录答案模型

#import <Foundation/Foundation.h>

@interface ZTHAnswerModel : NSObject

@property (nonatomic, copy) NSString *num;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString * answerID;

@end
