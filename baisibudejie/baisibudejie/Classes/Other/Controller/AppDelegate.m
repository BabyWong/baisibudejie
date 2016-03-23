//
//  AppDelegate.m
//  baisibudejie
//
//  Created by hwm on 16/3/15.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "AppDelegate.h"
#import "WMTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    WMTabBarController *vc = [[WMTabBarController alloc] init];
    self.window.rootViewController = vc;
    
    
    [self.window makeKeyAndVisible];
    
    
//    // 设置友盟AppKey
//    [UMSocialData setAppKey:@"56a58cefe0f55a7471000fe3"];
//    
//    //设置分享到QQ/Qzone的应用Id，和分享url 链接
//    [UMSocialQQHandler setQQWithAppId:@"1105015310" appKey:@"3amibiEbZdpJR2SN" url:@"http://www.yg-technology.com"];
//    
//    //设置支持没有客户端情况下使用SSO授权
//    [UMSocialQQHandler setSupportWebView:YES];
//    
//    //设置微信AppId、appSecret，分享url
//    [UMSocialWechatHandler setWXAppId:@"wxcbeaebfd08a63b4f" appSecret:@"4f50be76dce1cb893a4951b694312c19" url:@"http://www.yg-technology.com"];
//    
//    //打开新浪微博的SSO开关设置新浪微博回调地址,这里必须要和在新浪微博后台设置的回调地址一致。
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954" secret:@"04b48b094faeb16683c32669824ebdad"
//                                         RedirectURL:@"http://www.yg-technology.com"];
//    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
