//
//  AppDelegate+KJJPushSDK.m
//  weijianlianxian
//
//  Created by apple on 2018/8/3.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "AppDelegate+KJJPushSDK.h"

//  AppDelegate+KJJPushSDK.m
//
//  Created by xiayuanquan on 16/5/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AppDelegate+KJJPushSDK.h"
#import "KJJPushHelper.h"

#define JPushSDK_AppKey  @"c1d2a037b16508ac0c17708b"
#define isProduction     NO

@implementation AppDelegate (KJJPushSDK)
-(void)JPushApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    [KJJPushHelper setupWithOption:launchOptions appKey:JPushSDK_AppKey channel:nil apsForProduction:0 advertisingIdentifier:nil];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Required - 注册 DeviceToken
    [KJJPushHelper registerDeviceToken:deviceToken];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [KJJPushHelper handleRemoteNotification:userInfo completion:nil];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
   
    // IOS 7 Support Required
    [KJJPushHelper handleRemoteNotification:userInfo completion:completionHandler];
    
    // 应用正处理前台状态下，不会收到推送消息，因此在此处需要额外处理一下
    if (application.applicationState == UIApplicationStateActive) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"收到推送消息"
                              message:userInfo[@"aps"][@"alert"]
                              delegate:nil
                              cancelButtonTitle:@"取消"
                              otherButtonTitles:@"确定",nil];
        [alert show];
    }
   
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [KJJPushHelper showLocalNotificationAtFront:notification];
    return;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    return;
}

@end
