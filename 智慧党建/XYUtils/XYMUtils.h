//
//  XYMUtils.h
//  MobileApp
//
//  Created by yuanguozheng on 2017/6/23.
//  Copyright © 2017年 xiyoumobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <CoreMedia/CMTime.h>

/*!
 @class
 @abstract 通用工具类
 */
@interface XYMUtils : NSObject

+ (NSString *)sha1:(NSString *)input;

/**
 获取MIME 根据路径后缀
 
 @param path 路径
 @return 国际通用的MIME
 */
+ (NSString *)getMIMETypeWithPath:(NSURL *)path;


+ (NSString *)formatPublicKey:(NSString *)publicKey ;
#pragma mark 字符串相关
/**
 *  @brief  当前对象是否是字符串
 *
 *  @param string  待验证字符串
 *
 *  @return BOOL值
 */
+ (BOOL)isStringValidated:(NSString *)string;

/**
 *  @brief  当前对象是否是字典
 *
 *  @param dictionary  待验证字典
 *
 *  @return BOOL值
 */
+ (BOOL)isDictionaryValidated:(NSDictionary *)dictionary;

/**
 *  @brief  当前对象是否是数组
 *
 *  @param array  待验证数组
 *
 *  @return BOOL值
 */
+ (BOOL)isArrayValidated:(NSArray *)array;

/**
 *  @brief  当前对象是否是集合
 *
 *  @param set  待验证集合
 *
 *  @return BOOL值
 */
+ (BOOL)isSetValidated:(NSSet *)set;

/*!
 @method
 @abstract 判断字符串是否为空

 */
+ (BOOL)isEmptyString:(NSString *)string;

/*!
 @method
 @abstract 判断判断字典是否为空

 */
+ (BOOL)isEmptyDictionary:(NSDictionary *)dictionary;

/*!
 @method
 @abstract 判断数组是否为空

 */
+ (BOOL)isEmptyArray:(NSArray *)array;

/*!
 @method
 @abstract 判断集合是否为空

 */
+ (BOOL)isEmptySet:(NSSet *)set;

/*!
 @method
 @abstract 获取随机数

 */
+ (int)getRandomNumber:(int)from to:(int)to;

/**
 生成随机字符串

 @param length 长度
 @return Str
 */
+ (NSString *)getRandomString:(int)length;

/*!
 @method
 @abstract 四舍五入

 */
+ (double)notRounding:(double)price afterPoint:(int)position mode:(NSRoundingMode)roundingMode;

/*!
 @method
 @abstract 去掉空格

 */
+ (NSString *)stringTrimming:(NSString *)str;

/*!
 @method
 @abstract 生成唯一标识符

 */
+ (NSString*)createCFUUID;

/*!
 @method
 @abstract 获得设备型号

 */
+ (NSString *)getCurrentDeviceModel;

/*!
 @method
 @abstract 生成JSON字符串

 */
+ (NSString *)toJSONString:(id)theData;

/*!
 @method
 @abstract 生成文本字符串

 */
+ (NSString *)toPlainString:(NSString *)html;

/*!
 @method
 @abstract 根据内容获取label的实际大小

 */
+ (CGSize)getExpectSize:(UILabel *)label content:(NSString *)content;

/*!
 @method
 @abstract 根据内容获取label的实际大小, label宽度是否固定，NO代表高度固定长度Infinity

 */
+ (CGSize)getExpectSize:(UILabel *)label content:(NSString *)content isWidthFixed:(BOOL)isWidthFixed;

/*!
 @method
 @abstract 改变字符串中特定字符的属性

 */
+ (NSMutableAttributedString *)buildAttrebuteString:(NSString *)preString
                                               info:(NSString *)info
                                               attr:(NSString *)attr
                                              value:(id)value;

/**
 *  @brief  判读字符串是否是整数
 *
 *  @param string 字符串
 *
 *  @return 布尔值
 */
+ (BOOL)isPureInt:(NSString*)string;

/**
 *  @brief 判读字符是数字
 *
 *  @param string 字符串
 *
 *  @return 布尔值
 */
+ (BOOL)isPureNumber:(NSString*)string;


/**
 *  @brief 把对象转换成string
 *
 *  @param object 待转化对象
 *
 *  @return 返回字符串
 */
+ (NSString *)otherObjectsToString:(id)object;



#pragma mark 加密相关
/*!
 @method
 @abstract MD5加密

 */
+ (NSString *)md5Hash:(NSString *)content;

/**
 SHA256

 @param str 要取SHA256的字符串
 @return SHA256字符串
 */
+ (NSString *)sha256:(NSString *)str;

/*!
 @method
 @abstract AES加密

 */
+ (NSString *)requestAESStringWithUserID:(NSString *)uid AESKey:(NSString *)key;

/*!
 @method
 @abstract urlEncoded编码

 */
+ (NSString*)urlEncoded:(NSString*)strTxt;

/*!
 @method
 @abstract urlEncoded编码
 中文输入法输入时文本框先出现拼音，而这个拼音会伴有"%E2%80%86"占位符(类似于空格)，该接口可过滤掉该字符
 */
+ (NSString*)urlEncoded1:(NSString*)strTxt;

/*!
 @method
 @abstract base64编码

 */
+(NSData *)encodeData:(NSData *)aData;

/*!
 @method
 @abstract base64解码

 */
+(NSData *)decodeData:(NSData *)aData;

#pragma mark 图片相关
/*!
 @method
 @abstract 加载图片

 */
+ (UIImage *)imageWithName:(NSString *)name;

/*!
 @method
 @abstract 加载图片

 */
+ (UIImage *)imageWithName:(NSString *)name ofType:(NSString *)type;

/*!
 @method
 @abstract 获取纯色图片

 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/*!
 @method
 @abstract 获取颜色

 */
+ (UIColor*)colorWithRgbHexString:(NSString*)hexString;

/*!
 @method
 @abstract view to image

 */
+ (UIImage *)getImageFromView:(UIView *)theView;

#pragma mark 时间相关

/*!
 @method
 @abstract 获取时间component

 */
+ (NSDateComponents *)getComponentByDate:(NSDate *)date;

/*!
 @method
 @abstract 获取相对时间

 */
+ (NSString *)formatRelativeTime:(NSDate *)date;

/*!
 @method
 @abstract 转换时间为字符

 */
+ (NSDate*)convertDateFromString:(NSString *)strDate;

/*!
 @method
 @abstract 转换字符为时间

 */
+ (NSDate *)formatDateFromString:(NSString *)strDate;

/*!
 @method
 @abstract 转换时间为星期几

 */
+ (NSString *)weekdayForDate:(NSDate *)date;

/*!
 @method
 @abstract 转换时间为星期几返回整数

 */
+ (NSInteger)weekdayNumForDate:(NSDate *)date;

/*!
 @method
 @abstract 获取CMTime

 */
+ (NSString *)stringByCMTime:(CMTime)time;

/*!
 @method
 @abstract 获取时间通过秒

 */
+ (NSString *)stringBySecond:(CGFloat)duration;

/*!
 @method
 @abstract 获取当前

 */
+ (NSDate *)getCurrentDate;

/*!
 @method
 @abstract 获取1970年到当前时间的时间间隔
 精确到秒，返回NSNumber类型
 */
+ (NSNumber *)getTimeIntervalStringSince1970;

/*!
 @method
 @abstract 指定format转换string到date

 */
+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format;

/*!
 @method
 @abstract  默认标准format转换string到date

 */
+ (NSDate *)dateFromString:(NSString *)dateString;

/*!
 @method
 @abstract 指定format转换date到string

 */
+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format;

/*!
 @method
 @abstract 转换日期string的format

 */
+ (NSString *)changeFormat:(NSString *)string from:(NSString *)fromFormat to:(NSString *)toFormat;

/*!
 @method
 @abstract 转换日期string的format

 */
+ (NSString *)changeFormat:(NSString *)string toFormat:(NSString *)toFormat;

/*!
 @method
 @abstract 获取系统键盘

 */
+ (UIWindow *)systemKeyboardWindow;

/*!
 @method
 @abstract 自动适配屏幕

 */
+ (CGRect)calculateFrameToFitScreenBySize:(CGSize)size;

/*!
 @method
 @abstract 从共享内容获取连接

 */
+ (NSString *)getLinkFromShareContent:(NSString *)content;

#pragma mark 正则表达式校验相关
/*!
 @method
 @abstract 手机号码格式校验

 */
+ (BOOL)isMobileNumber:(NSString *)mobile;
/*!
 @method
 @abstract 电话号码格式校验

 */
+ (BOOL)isPhoneNumber:(NSString *)phone;

/**
 *  @brief  邮箱判断
 *
 *  @param email 邮箱地址
 *
 *  @return 布尔值
 */
+ (BOOL) validateEmail:(NSString *)email;

/**
 *  @brief  网址判读
 *
 *  @param value url
 *
 *  @return 布尔值
 */
+ (BOOL) isValidUrl:(NSString*)url;

/**
 *  @brief  邮编判读
 *
 *  @param value 邮编值
 *
 *  @return 布尔值
 */
+ (BOOL) isValidZipcode:(NSString*)value;

/**
 截图

 @param view 需要截图得View
 @return 截取的UIImage
 */
+ (UIImage *)screenshotOfView:(UIView *)view;
@end

#pragma mark - AES Encrypt/Decrypt (Optional)
@interface NSData (AES256)

/*!
 @method
 @abstract 加密方法,参数需要加密的内容

 */
+ (NSString *)AES256EncryptWithPlainText:(NSString *)plain AESKey:(NSString *)aeskey;

/*!
 @method
 @abstract 解密方法，参数数密文

 */
+ (NSString *)AES256DecryptWithCiphertext:(NSString *)ciphertexts  AESKey:(NSString *)aeskey;

- (NSString *)base64Encoding;

@end

#pragma mark - AES Encrypt/Decrypt (Basic)
@interface NSData (AESAdditions)

- (NSData*)AES256EncryptWithKey:(NSString*)key;

- (NSData*)AES256DecryptWithKey:(NSString*)key;

@end

@interface NSString (AESAdditions)

- (NSString *)AES256EncryptWithKey:(NSString *)key;

- (NSString *)AES256DecryptWithKey:(NSString *)key;

@end
