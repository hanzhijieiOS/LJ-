//
//  XYUtils.h
//  智慧党建
//
//  Created by 韩智杰 on 2018/12/17.
//  Copyright © 2018年 韩智杰. All rights reserved.
//

#import "XYUtils.h"
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>
#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonKeyDerivation.h>
#include <sys/sysctl.h>

@implementation XYUtils

+ (NSString *)sha1:(NSString *)input{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

+ (UIImage *)screenshotOfView:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.frame.size, YES, 0.0);
    
    if ([view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    }
    else{
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (NSString *)formatPublicKey:(NSString *)publicKey {
    
    NSMutableString *result = [NSMutableString string];
    
    [result appendString:@"-----BEGIN PUBLIC KEY-----\n"];
    
    int count = 0;
    
    for (int i = 0; i < [publicKey length]; ++i) {
        
        unichar c = [publicKey characterAtIndex:i];
        if (c == '\n' || c == '\r') {
            continue;
        }
        [result appendFormat:@"%c", c];
        if (++count == 76) {
            [result appendString:@"\n"];
            count = 0;
        }
        
    }
    
    [result appendString:@"\n-----END PUBLIC KEY-----\n"];
    
    return result;
    
}
+ (BOOL)isStringValidated:(NSString *)string
{
    bool result = false;
    if (string && [string isKindOfClass:[NSString class]]) {
        result = true;
    }
    return result;
}

+ (BOOL)isDictionaryValidated:(NSDictionary *)dictionary
{
    bool result = false;
    if (dictionary && [dictionary isKindOfClass:[NSDictionary class]]) {
        result = true;
    }
    return result;
    
}

+ (BOOL)isArrayValidated:(NSArray *)array
{
    bool result = false;
    if (array && [array isKindOfClass:[NSArray class]]) {
        result = true;
    }
    return result;
}

+ (BOOL)isSetValidated:(NSSet *)set
{
    bool result = false;
    if (set && [set isKindOfClass:[NSSet class]]) {
        result = true;
    }
    return result;
}

+ (BOOL)isEmptyString:(NSString *)string
{
    BOOL result = YES;
    if ([self isStringValidated:string] && string.length != 0) {
        result = NO;
    }
    
    return result;
}

+ (BOOL)isEmptyDictionary:(NSDictionary *)dictionary
{
    BOOL result = YES;
    if ([self isDictionaryValidated:dictionary] && [dictionary count] != 0 ) {
        return NO;
    }
    
    return result;
}

+ (BOOL)isEmptyArray:(NSArray *)array
{
    BOOL result = YES;
    if ([self isArrayValidated:array] && array.count != 0) {
        result = NO;
    }
    
    return result;
}

+ (BOOL)isEmptySet:(NSSet *)set
{
    BOOL result = YES;
    if ([self isSetValidated:set] && set.count != 0) {
        result = NO;
    }
    
    return result;
}

+ (NSString*)urlEncoded:(NSString*)strTxt
{
    CFStringRef cfUrlEncodedString = CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                             (CFStringRef)strTxt,NULL,
                                                                             (CFStringRef)@"!#$%&'()*+,/:;=?@[]",
                                                                             kCFStringEncodingUTF8);
    
    NSString *urlEncoded = [NSString stringWithString:(__bridge NSString *)cfUrlEncodedString];
    CFRelease(cfUrlEncodedString);
    return urlEncoded;
}

+ (NSString*)urlEncoded1:(NSString*)strTxt
{
    CFStringRef cfUrlEncodedString = CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                             (CFStringRef)strTxt,NULL,
                                                                             (CFStringRef)@"!#$%&'()*+,/:;=?@[]",
                                                                             kCFStringEncodingUTF8);
    
    NSString *urlEncoded = [NSString stringWithString:(__bridge NSString *)cfUrlEncodedString];
    CFRelease(cfUrlEncodedString);
    return [urlEncoded stringByReplacingOccurrencesOfString:@"%E2%80%86" withString:@""];
}

+ (NSString *)md5Hash:(NSString *)content
{
    if ([self isEmptyString:content]) {
        return nil;
    }
    
    const char* str = [content UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}
+ (NSString *)sha256:(NSString *)str
{
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(data.bytes, data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

+ (NSString*)createCFUUID
{
    CFUUIDRef deviceId = CFUUIDCreate (NULL);
    CFStringRef deviceIdStringRef = CFUUIDCreateString(NULL,deviceId);
    CFRelease(deviceId);
    
    NSString* deviceIdString = (__bridge NSString *)deviceIdStringRef;
    CFRelease(deviceIdStringRef);
    return deviceIdString;
}

//获得设备型号
+ (NSString *)getCurrentDeviceModel
{
    //    NSString *platform = [UIDevice currentDevice].model;
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
}

+ (NSString *)toJSONString:(id)theData
{
    if(!theData)
        return nil;
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if ([jsonData length] > 0 && error == nil){
        NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding];
        return jsonString;
    }else{
        return nil;
    }
}

+ (NSString *)toPlainString:(NSString *)html {
    NSScanner *scanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    while([scanner isAtEnd] == NO) {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text]
                                               withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}

+ (NSString *)stringTrimming:(NSString *)str {
    if (![str isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    //clear symbole in token string
    //	NSString *urlString = [str stringByTrimmingCharactersInSet:[NSCharacterSet symbolCharacterSet]];
    //clear space in token string
    NSString *urlString = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return urlString;
}

+ (NSString *)getLinkFromShareContent:(NSString *)content {
    if (content.length==0) {
        return nil;
    }
    NSString *link = nil;
    NSString *linkHeader = @"http://";
    NSRange rangHeader = [content rangeOfString:linkHeader options:NSCaseInsensitiveSearch|NSBackwardsSearch];
    if (rangHeader.location != NSNotFound) {
        NSString *subStr = [content substringFromIndex:rangHeader.location + [linkHeader length]];
        int subStringLen = [subStr length];
        unichar ch = 0;
        int linkEndIndex = 0;
        for (int nIndex = 0; nIndex < subStringLen; nIndex++) {
            ch = [subStr characterAtIndex:nIndex];
            if (!isascii(ch) || isblank(ch)) {
                linkEndIndex = nIndex;
                break;
            }
            if (nIndex == subStringLen - 1) {
                linkEndIndex = nIndex + 1;
                break;
            }
        }
        if (linkEndIndex) {
            link = [content substringWithRange:NSMakeRange(rangHeader.location, rangHeader.length + linkEndIndex)];
        }
    }
    
    return link;
}

+ (NSString *)requestAESStringWithUserID:(NSString *)uid AESKey:(NSString *)key {
    NSString *result = nil;
    
    NSString *_mobileType = @"iphone";
    u_int32_t _randomInt = arc4random();
    NSString *_preAESString = [NSString stringWithFormat:@"%@|%@|%u", _mobileType, uid, _randomInt];
    
    result = [NSData AES256EncryptWithPlainText:_preAESString AESKey:key];
    //result = [_preAESString AES256EncryptWithKey:key];
    
    return result;
}

+ (CGSize)getExpectSize:(UILabel *)label content:(NSString *)content {
    return [self getExpectSize:label content:content isWidthFixed:NO];
}

+ (NSMutableAttributedString *)buildAttrebuteString:(NSString *)preString
                                               info:(NSString *)info
                                               attr:(NSString *)attr
                                              value:(id)value {
    if (![self isStringValidated:preString]) {
        return nil;
    }
    NSMutableAttributedString *resultString = [[NSMutableAttributedString alloc] initWithString:preString];
    
    NSRange range = [preString rangeOfString:info];
    
    while (range.location != NSNotFound) {
        [resultString addAttribute:attr value:value range:range];
        NSRange searchRange = NSMakeRange(range.location + range.length, preString.length - range.location - range.length);
        range = [preString rangeOfString:info options:NSLiteralSearch range:searchRange];
    }
    return resultString;
}

+ (UIImage *)imageWithName:(NSString *)name
{
    NSMutableString *fullName = [[NSMutableString alloc] initWithString:name];
    if (![name hasSuffix:@"@2x"]) {
        [fullName appendString:@"@2x"];
    }
    return [XYUtils imageWithName:fullName ofType:@"png"];
}

+ (UIImage *)imageWithName:(NSString *)name ofType:(NSString *)type
{
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:type]];
}

+ (UIImage *)scaleImageWithName:(NSString*)imgname
{
    return [[UIImage alloc] initWithCGImage:
            [XYUtils imageWithName:imgname].CGImage scale:1.0 orientation:UIImageOrientationDown];
}

+ (UIColor *)colorWithRgbHexValue:(uint)hexValue {
    return [UIColor
            colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0f
            green:((float)((hexValue & 0x00FF00) >> 8))/255.0f
            blue:((float)(hexValue & 0x0000FF))/255.0f
            alpha:1.0f];
}

+ (UIColor*)colorWithRgbHexString:(NSString*)hexString {
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#"
                                                     withString:@""];
    
    uint hexValue;
    if ([[NSScanner scannerWithString:hexString] scanHexInt:&hexValue]) {
        return [[self class] colorWithRgbHexValue:hexValue];
    } else {
        return nil;
    }
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/*!
 @method
 @abstract view to image
 @discussion
 */
+ (UIImage *)getImageFromView:(UIView *)theView {
    UIGraphicsBeginImageContextWithOptions(theView.bounds.size, YES, theView.layer.contentsScale);
    [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (CGRect)calculateFrameToFitScreenBySize:(CGSize)size
{
    CGFloat width, height;
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    
    if (size.width / size.height > bounds.size.width / bounds.size.height) {
        width = bounds.size.width;
        height = size.height/size.width * bounds.size.width;
        
    } else {
        width = size.width/size.height * bounds.size.height;
        height = bounds.size.height;
    }
    
    
    CGFloat xd = width - bounds.size.width;
    CGFloat yd = height - bounds.size.height;
    
    return CGRectMake(-xd/2, -yd/2, width, height);
}

+ (NSDateComponents *)getComponentByDate:(NSDate *)date {
    NSCalendar *calendar;
#ifdef __IPHONE_8_0
    calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    NSDateComponents *componentsCurrentDate = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:date];
    return componentsCurrentDate;
}



+ (NSDate*)convertDateFromString:(NSString *)strDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [formatter dateFromString:strDate];
    return date;
}


+ (NSDate *)formatDateFromString:(NSString *)strDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    NSDate *date = [formatter dateFromString:strDate];
    
    return date;
}

+ (NSString *)weekdayForDate:(NSDate *)date {
    NSString *weekday = @"";
    NSCalendar *cld = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *cpn = [cld components:NSWeekdayCalendarUnit fromDate:date];
    switch (cpn.weekday) {
        case 1:
            weekday = @"星期日";
            break;
        case 2:
            weekday = @"星期一";
            break;
        case 3:
            weekday = @"星期二";
            break;
        case 4:
            weekday = @"星期三";
            break;
        case 5:
            weekday = @"星期四";
            break;
        case 6:
            weekday = @"星期五";
            break;
        case 7:
            weekday = @"星期六";
            break;
            
        default:
            break;
    }
    return weekday;
}

+ (NSInteger)weekdayNumForDate:(NSDate *)date
{
    NSCalendar *cld = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *cpn = [cld components:NSWeekdayCalendarUnit fromDate:date];
    return cpn.weekday;
}


+ (NSString *)stringByCMTime:(CMTime)time
{
    Float64 duration  = CMTimeGetSeconds(time);
    
    NSUInteger dHours = floor(duration / 3600);
    NSUInteger dMinutes = floor((NSUInteger)duration%3600/60);
    NSUInteger dSeconds = floor((NSUInteger)duration%3600%60);
    
    if (dHours > 0) {
        return [NSString stringWithFormat:@"%lu:%02lu:%02lu",(unsigned long)dHours, (unsigned long)dMinutes, (unsigned long)dSeconds];
    } else {
        return [NSString stringWithFormat:@"%02lu:%02lu", (unsigned long)dMinutes, (unsigned long)dSeconds];
    }
    
    return nil;
}

+ (NSString *)stringBySecond:(CGFloat)duration
{
    NSUInteger dHours = floor(duration / 3600);
    NSUInteger dMinutes = floor((NSUInteger)duration%3600/60);
    NSUInteger dSeconds = floor((NSUInteger)duration%3600%60);
    
    if (dHours > 0) {
        return [NSString stringWithFormat:@"%lu:%02lu:%02lu",(unsigned long)dHours, (unsigned long)dMinutes, (unsigned long)dSeconds];
    } else {
        return [NSString stringWithFormat:@"%02lu:%02lu", (unsigned long)dMinutes, (unsigned long)dSeconds];
    }
    
    return nil;
}

+ (NSDate *)getCurrentDate
{
    NSDate *dateNow = [NSDate date];
    //    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //    NSInteger interval = [zone secondsFromGMTForDate:dateNow];
    //    NSDate *localeDate = [dateNow  dateByAddingTimeInterval: interval];
    return dateNow;
}

+ (NSNumber *)getTimeIntervalStringSince1970
{
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    return [NSNumber numberWithDouble:timeInterval];
}

+ (BOOL)isPureInt:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

+ (BOOL)isPureFloat:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

+ (BOOL)isPureNumber:(NSString*)string
{
    return ([self isPureInt:string] ||[self isPureFloat:string]);
}

+ (NSString *)otherObjectsToString:(id)object {
    if (object) {
        return [NSString stringWithFormat:@"%@",object];
    }
    return @"";
}

+ (UIViewController *)getTopViewController{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [[self class] getCurrentVCFrom:rootViewController];
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        currentVC = [[self class] getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        currentVC = [[self class] getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        currentVC = rootVC;
    }
    return currentVC;
}

#pragma mark - Date Formating Methods

+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format
{
    if (![[self class] isStringValidated:dateString])
        return nil;
    
    if (!format) {
        format =  @"yyyy-MM-dd HH:mm:ss";
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = format;
    return [dateFormatter dateFromString:dateString];
}


+ (NSDate *)dateFromString:(NSString *)dateString
{
    return [[self class] dateFromString:dateString format:nil];
}

+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format
{
    if (!format) {
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = format;
    return [fmt stringFromDate:date];
}

+ (NSString *)changeFormat:(NSString *)string from:(NSString *)fromFormat to:(NSString *)toFormat
{
    NSDate *date = [self dateFromString:string format:fromFormat];
    NSString *dString = [self stringFromDate:date format:toFormat];
    
    return dString;
}

+ (NSString *)changeFormat:(NSString *)string toFormat:(NSString *)toFormat
{
    NSDate *date = [self dateFromString:string];
    NSString *dString = [self stringFromDate:date format:toFormat];
    
    return dString;
}

+ (int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1))); //+1,result is [from to]; else is [from, to)!!!!!!!
}

+ (NSString *)getRandomString:(int)length {
    char data[length];
    for (int x = 0; x < length; data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:length encoding:NSUTF8StringEncoding];
}

+ (UIWindow *)systemKeyboardWindow
{
    UIWindow *keyboardWindow = nil;
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        if (![NSStringFromClass([window class]) isEqualToString:NSStringFromClass([UIWindow class])])
        {
            keyboardWindow = window;
            break;
        }
    }
    return keyboardWindow;
}

+ (double)notRounding:(double)price afterPoint:(int)position mode:(NSRoundingMode)roundingMode
{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:roundingMode scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithDouble:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [roundedOunces doubleValue];
}

+ (BOOL)isMobileNumber:(NSString *)mobile
{
    if ([[self class] isEmptyString:mobile])
        return NO;
    
    //手机号码匹配
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"^(\\+86)?((13[0-9])|(147)|(17[0-9])|(15[^4,\\D])|(18[0-9]))\\d{8}$" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSRange range = NSMakeRange(0, mobile.length);
    
    if ([regex numberOfMatchesInString:mobile options:NSMatchingReportCompletion range:range])
        return YES;
    return NO;
    
}

+ (BOOL)isPhoneNumber:(NSString *)phone {
    if ([[self class] isEmptyString:phone])
        return NO;
    //电话号码匹配
    //修改电话号码匹配增加分机号匹配
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"^(\\(?\\d{3,4}\\)?)?-?(\\d{7,8})(-(\\d{3,4}))?$" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSRange range = NSMakeRange(0, phone.length);
    if ([regex numberOfMatchesInString:phone options:NSMatchingReportCompletion range:range])
        return YES;
    
    return NO;
}

+ (BOOL) validateEmail:(NSString *)email
{
    if ([[self class] isEmptyString:email])
        return NO;
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL) isValidUrl:(NSString*)url {
    if ([[self class] isEmptyString:url])
        return NO;
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"^([hH][tT]{2}[pP]:\\/\\/|[hH][tT]{2}[pP][sS]:\\/\\/)?(([A-Za-z0-9-~]+)\\.)+([A-Za-z0-9-~\\/])+$" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSRange range = NSMakeRange(0, url.length);
    if ([regex numberOfMatchesInString:url options:NSMatchingReportCompletion range:range])
        return YES;
    
    return NO;
}

+ (BOOL) isValidZipcode:(NSString*)value
{
    if ([[self class] isEmptyString:value])
        return NO;
    const char *cvalue = [value UTF8String];
    int len = strlen(cvalue);
    if (len != 6) {
        return NO;
    }
    for (int i = 0; i < len; i++)
    {
        if (!(cvalue[i] >= '0' && cvalue[i] <= '9'))
        {
            return YES;
        }
    }
    return YES;
}

@end


#pragma mark Image
@implementation UIImage (SNImage)

+ (void)beginImageContextWithSize:(CGSize)size
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        if ([[UIScreen mainScreen] scale] == 2.0) {
            UIGraphicsBeginImageContextWithOptions(size, YES, 2.0);
        } else {
            UIGraphicsBeginImageContext(size);
        }
    } else {
        UIGraphicsBeginImageContext(size);
    }
}

+ (void)endImageContext
{
    UIGraphicsEndImageContext();
}

+ (UIImage*)imageFromView:(UIView*)view
{
    [self beginImageContextWithSize:[view bounds].size];
    BOOL hidden = [view isHidden];
    [view setHidden:NO];
    [[view layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    [self endImageContext];
    [view setHidden:hidden];
    return image;
}

@end

#pragma mark - AES Encrypt/Decrypt (Optional)

#define PASSWORD @"8xtmTy8PK4QPmVscyb2Tcw=="

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
const NSUInteger kAlgorithmKeySize = kCCKeySizeAES256;
const NSUInteger kPBKDFRounds = 10000;  // ~80ms on an iPhone 4

static Byte saltBuff[] = {0,1,2,3,4,5,6,7,8,9,0xA,0xB,0xC,0xD,0xE,0xF};

static Byte ivBuff[]   = {0xA,1,0xB,5,4,0xF,7,9,0x17,3,1,6,8,0xC,0xD,91};

@implementation NSData (AES256)

+ (NSData *)AESKeyForPassword:(NSString *)password{                  //Derive a key from a text password/passphrase
    
    NSMutableData *derivedKey = [NSMutableData dataWithLength:kAlgorithmKeySize];
    
    NSData *salt = [NSData dataWithBytes:saltBuff length:kCCKeySizeAES128];
    
    int result = CCKeyDerivationPBKDF(kCCPBKDF2,        // algorithm算法
                                      password.UTF8String,  // password密码
                                      password.length,      // passwordLength密码的长度
                                      salt.bytes,           // salt内容
                                      salt.length,          // saltLen长度
                                      kCCPRFHmacAlgSHA1,    // PRF
                                      kPBKDFRounds,         // rounds循环次数
                                      derivedKey.mutableBytes, // derivedKey
                                      derivedKey.length);   // derivedKeyLen derive:出自
    
    NSAssert(result == kCCSuccess,
             @"Unable to create AES key for spassword: %d", result);
    return derivedKey;
}

/*加密方法*/
+ (NSString *)AES256EncryptWithPlainText:(NSString *)plain AESKey:(NSString *)aeskey {
    NSData *plainText = [plain dataUsingEncoding:NSUTF8StringEncoding];
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    NSUInteger dataLength = [plainText length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    bzero(buffer, sizeof(buffer));
    
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,kCCOptionPKCS7Padding,
                                          [[NSData AESKeyForPassword:aeskey] bytes], kCCKeySizeAES256,
                                          ivBuff /* initialization vector (optional) */,
                                          [plainText bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *encryptData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        return [encryptData base64Encoding];
    }
    
    free(buffer); //free the buffer;
    return nil;
}

/*解密方法*/
+ (NSString *)AES256DecryptWithCiphertext:(NSString *)ciphertexts  AESKey:(NSString *)aeskey {
    NSData *cipherData = [NSData dataWithBase64EncodedString:ciphertexts];
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    NSUInteger dataLength = [cipherData length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          [[NSData AESKeyForPassword:aeskey] bytes], kCCKeySizeAES256,
                                          ivBuff ,/* initialization vector (optional) */
                                          [cipherData bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *encryptData = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        return [[NSString alloc] initWithData:encryptData encoding:NSUTF8StringEncoding];
    }
    
    free(buffer); //free the buffer;
    return nil;
}

+ (id)dataWithBase64EncodedString:(NSString *)string;
{
    if (string == nil)
        [NSException raise:NSInvalidArgumentException format:nil];
    if ([string length] == 0)
        return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

- (NSString *)base64Encoding;
{
    if ([self length] == 0)
        return @"";
    
    char *characters = malloc((([self length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [self length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [self length])
            buffer[bufferLength++] = ((char *)[self bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}
@end

#pragma mark - AES Encrypt/Decrypt (Basic)
#import <CommonCrypto/CommonCryptor.h>

@implementation NSData (AESAdditions)
- (NSData*)AES256EncryptWithKey:(NSString*)key {
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256 + 1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize           = dataLength + kCCBlockSizeAES128;
    void* buffer                = malloc(bufferSize);
    
    size_t numBytesEncrypted    = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess)
    {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSMutableData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
}

- (NSData*)AES256DecryptWithKey:(NSString*)key {
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256 + 1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize           = dataLength + kCCBlockSizeAES128;
    void* buffer                = malloc(bufferSize);
    
    size_t numBytesDecrypted    = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess)
    {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSMutableData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
}

@end
