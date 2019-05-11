//
//  AppDelegate.m
//  智慧党建
//
//  Created by 韩智杰 on 2018/12/16.
//  Copyright © 2018年 韩智杰. All rights reserved.
//

#import "AppDelegate.h"
#import "XYTabBarController.h"
#import "XYNewsManager.h"
#import "XYLoginManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    BOOL isLogin = [[XYLoginManager sharedManager] isLogin];
    if (isLogin) {
        NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:XYCurrentUserAccount];
        if (dic) {
            [[XYLoginManager sharedManager] loginWithAccount:[dic objectForKey:XYCurrentUsername] password:[dic objectForKey:XYCurrentUserPassword] succeedBlock:^(XYLoginModel * _Nonnull model) {
            } failureBlock:^(NSError * _Nonnull error) {
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:XYUserLoginStatus];
            }];
        }
    }
    XYTabBarController * tabBarVC = [[XYTabBarController alloc] init];
    [tabBarVC initSubViewController];
    self.window.rootViewController = tabBarVC;
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    NSString * string = url.absoluteString;
    NSArray * array = [string componentsSeparatedByString:@"://"];
    if ([[array.firstObject lowercaseString] isEqualToString:@"xyhome"]) {
        return [[JLRoutes routesForScheme:@"XYHome"] routeURL:url];
    }else if ([[array.firstObject lowercaseString] isEqualToString:@"xymessage"]){
        return [[JLRoutes routesForScheme:@"XYMessage"] routeURL:url];
    }else if ([[array.firstObject lowercaseString] isEqualToString:@"xyfind"]){
        return [[JLRoutes routesForScheme:@"XYFind"] routeURL:url];
    }else if ([[array.firstObject lowercaseString] isEqualToString:@"xymine"]){
        return [[JLRoutes routesForScheme:@"XYMine"] routeURL:url];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
