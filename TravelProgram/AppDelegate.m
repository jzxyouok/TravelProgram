//
//  AppDelegate.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/8.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "AppDelegate.h"
#import "BSUITabBarController.h"
#import "AFNetworkReachabilityManager.h"
#import "SingleStaues.h"
#import "UMSocial.h"
#import "Reachability.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
- (void)dealloc
{
    [_window release];
    [super dealloc];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [NSThread sleepForTimeInterval:1.5];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    Reachability *reach = [Reachability reachabilityWithHostName:@"https://www.baidu.com"];
    [[SingleStaues shareNetStatus] setStatues:[reach currentReachabilityStatus]];
    //创建一个单例将网络状态传入
    AFNetworkReachabilityManager *connectManager = [AFNetworkReachabilityManager sharedManager];
    [connectManager startMonitoring];
    [connectManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        [[SingleStaues shareNetStatus] setStatues:status];
    }];
    //缓存文件夹创建
    NSString *diaryInfo = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"diaryInfo"];
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager createDirectoryAtPath:diaryInfo withIntermediateDirectories:YES attributes:nil error:nil];
    [UMSocialData setAppKey:@"562737e6e0f55ada18000028"];
    //初始化一个UITabBarController并设置为根视图控制器
    BSUITabBarController *root = [[BSUITabBarController alloc]init];
    [root.tabBar setBarTintColor:[UIColor blackColor]];
    [root.tabBar setTintColor:[UIColor whiteColor]];
    [self.window setRootViewController:root];
    [root release];
    [self.window makeKeyAndVisible];
    [_window release];
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
