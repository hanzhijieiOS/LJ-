//
//  XYMUIKit.h
//  MobileApp
//
//  Created by dengtuotuo on 2017/7/27.
//  Copyright © 2017年 xiyoumobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYMUIKit : NSObject


/**
 *  解决图片旋转
 *
 *  @param aImage 原始图片
 *
 *  @return 添加 EXIF 信息图片
 */
+ (UIImage*)fixImageOrientation:(UIImage *)aImage ;


+(UIImage *)imageName:(NSString *)imageName ofBundle:(NSString *)bundleName;
@end
