//
//  AppDelegate.m
//  Bee
//
//  Created by yaoshuai on 16/9/7.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "AppDelegate.h"
#import <SMS_SDK/SMSSDK.h>
#import "YS_TabbarVC.h"
#import "HMGestureUnlockController.h"
#import "MG_NewFunctionViewController.h"
#import "WeiboSDK.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [self initShareSDK];
    
    
    [SMSSDK registerApp:@"16f7cd39591c5"
             withSecret:@"2b120295fdcbfcdb28843b53809fd082"];
    
    // 创建 window
    self.window = [[UIWindow alloc] initWithFrame:kScreenBounds];
    
    // window 设置根控制器
    self.window.rootViewController = [self pickViewContoller];
    
    // window 显示
    [self.window makeKeyAndVisible];
    
    // 把当前版本保存到沙盒当中
    [self saveAppVersion];
    
    return YES;
}


- (void)initShareSDK {
    
    [ShareSDK registerApp:@"17077adef4831" activePlatforms:@[@(SSDKPlatformTypeSinaWeibo)] onImport:^(SSDKPlatformType platformType) {
        
    
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        
        
        [appInfo SSDKSetupSinaWeiboByAppKey:@"3653435585" appSecret:@"eaddeb3c115be728841d882c22ec155c" redirectUri:@"http://www.itheima.com" authType:SSDKAuthTypeBoth];
        
    }];
    
}


- (UIViewController *)pickViewContoller
{

    // 判断 沙盒版本号 是不是 和当前程序版本号(info) 一致
    if ([[self loadSavedAppVersion] isEqualToString:[self loadAppVersion]]) {
        // 如果一致 并且设置了密码 显示手势解锁
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"GestureUnlockPassword"]) {
            return [[HMGestureUnlockController alloc] init];
        }
        else {
          
            // 如果一致 并且没有设置密码 显示 tabbarController
            
            return [[YS_TabbarVC alloc] init];
        }
    }
    
    else {
        // 如果不一致 显示 新特性
        return [[MG_NewFunctionViewController alloc] init];
    }
}

// 获取当前 info 的版本号
- (NSString *)loadAppVersion
{
    // 获取 info 字典
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
    
    // 获取当前程序的版本号
    NSString *appVersion = info[@"CFBundleShortVersionString"];
    return appVersion;
}

// 获取沙盒中的版本号
- (NSString *)loadSavedAppVersion
{
    // 获取 ud 单例
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud objectForKey:@"appVersion"];
}

// 把当前的版本号保存到沙盒
- (void)saveAppVersion
{
    // 获取 info 字典
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
    
    // 获取当前程序的版本号
    NSString *appVersion = info[@"CFBundleShortVersionString"];
    
    // 获取 ud 单例
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    // 保存到沙河当中
    [ud setObject:appVersion forKey:@"appVersion"];
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
    // 1.获取docPath
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    // 2.拼接
    NSString *filePath = [docPath stringByAppendingPathComponent:@"remarks.plist"];
    //3.清除指定缓存
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}

@end
