//
//  XYMMacroDefine.h
//  Xiyoumobile
//
//  Created by Xiyoumobile on 15/1/27.
//  Copyright (c) 2015年 Xiyoumobile. All rights reserved.
//

#ifndef iJobs_BDMMacroDefine_h
#define iJobs_BDMMacroDefine_h

//  RGB Color
#define SRGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
//  RGB Color 带有透明度
#define SRGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

// 16进制数转换成color值
#define SRGBCOLOR_HEX(hex) SRGBCOLOR(((hex & 0xFF0000 )>>16), ((hex & 0x00FF00 )>>8), (hex & 0x0000FF))



// 系统版本判断
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

// 文件路径
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define PATH_OF_CACHE       [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
#define PATH_OF_Libray      [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]

//当前软件版本号
#define SoftVersionString    ([[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey] stringByReplacingOccurrencesOfString:@"." withString:@""])
#define kAppVersion  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define kBuildVersion  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]
#define kSystemVersion [[UIDevice currentDevice] systemVersion]

//转换成字符串
#define CHANGE_TO_STRING(obj) (obj == nil || [obj isKindOfClass:[NSNull class]]) ? @"" : [NSString stringWithFormat:@"%@",obj]

//时间相关
#define TT_MINUTE 60
#define TT_HOUR   (60 * TT_MINUTE)
#define TT_DAY    (24 * TT_HOUR)
#define TT_5_DAYS (5 * TT_DAY)
#define TT_WEEK   (7 * TT_DAY)
#define TT_MONTH  (30.5 * TT_DAY)
#define TT_YEAR   (365 * TT_DAY)

//CGRect 相关的宏
#define RECT(x,y,w,h) CGRectMake(x,y,w,h)
#define SIZE(w,h) CGSizeMake(w,h)
#define PRINT_SELFFRAME if([]) 1
#define BOTTOM(v) (v.frame.origin.y + v. frame.size.height)
#define RIGHT(v) (v.frame.origin.x + v. frame.size.width)
#define HEIGHT(v) v.frame.size.height
#define LEFT(v) v.frame.origin.x
#define WIDTH(v) v.frame.size.width
#define TOP(v) v.frame.origin.y
#define POINT(x,y) CGPointMake(x, y)
#define PRINT_VIEW(tempview)  [UtilityFunction printRect:tempview.frame]
#define NAVHEIGTH self.navigationController.navigationBar.frame.size.height
#define STATUSHEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
#define TABBARHEIGHT self.tabBarController.tabBar.frame.size.height
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

//屏幕适配相关宏
#define RESIZEWIDTH375(w) w * (SCREENWIDTH / 375)
#define RESIZEHEIGHT667(h) h * (SCREENHEIGHT / 667)
#define SIZEADAPT(w,h) SIZE(RESIZEWIDTH375(w), RESIZEHEIGHT667(h))
#define CENTER(x,y) POINT(RESIZEWIDTH375(w), RESIZEHEIGHT667(h))

//程序启动相关
#define APP_EVER_LAUNCHED       @"everLaunched"
#define APP_FIRST_LAUNCHED      @"firstLaunch"

//清除缓存相关
#define LAST_CLEAN_CACHE_TIME   @"lastCleanCacheTime"

//安全引用相关定义
#define BlockWeakObject(obj, wobj) __weak __typeof__((__typeof__(obj))obj) wobj = obj
#define BlockStrongObject(obj, sobj) __typeof__((__typeof__(obj))obj) sobj = obj

// /////////////////////////////////////////////////////////////
// 切换主线程
// /////////////////////////////////////////////////////////////

#define dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

//NSUserDefaults key相关
#define K_UserIsLogin @"isLogin"
#define K_UserData @"userData"
#define K_UserDetailInfo @"userDetailInfo"
#define K_UserIsAdministrators @"userIsAdministrators"

#define IS_IPHONE_X (SCREEN_HEIGHT == 812)
//状态栏高度
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
//导航栏高度
#define kNavBarHeight 44.0
//底部TabBar高度
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
//顶部高度，状态栏+导航栏  64/88
#define kTopHeight (kStatusBarHeight + kNavBarHeight)
//底部安全区域得高度
#define kSafeAreaBottomHeight (SCREEN_HEIGHT == 812.0 ? 34 : 0)

#define ColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//通知相关
#define KXYMUserLoginStatusChangedNotification @"XYMUserLoginStatusChangedNotification"

#endif
