//
//  XYError.m
//  MobileApp
//
//  Created by dengtuotuo on 2017/7/11.
//  Copyright © 2017年 xiyoumobile. All rights reserved.
//

#import "XYMError.h"

@interface XYMError ()

@end

@implementation XYMError

-(instancetype)initWithErrorCode:(NSInteger)code msg:(NSString*)msg{
    self = [super init];
    if (self) {
        self.code = code;
        self.msg = msg;
    }
    return self;
}

+ (instancetype)errorWithSystemNSError:(NSError *)error
{
    XYMError *t_error = [[XYMError alloc] initWithErrorCode:error.code msg:error.domain];
    return t_error;
}



@end
