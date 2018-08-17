//
//  AppDelegate.m
//  wyoa
//
//  Created by apple on 2018/8/13.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "AppDelegate.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import "LoginViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    //显示加载网络的指示符
    [[AFNetworkActivityIndicatorManager sharedManager]setEnabled:YES];
    //设置缓存
    NSURLCache *cache=[[NSURLCache alloc]initWithMemoryCapacity:1024*1024*10 diskCapacity:1024*1024*1024 diskPath:@"wyoa-cache"];
    [NSURLCache setSharedURLCache:cache];
    //创建window
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UIStoryboard *loginStoryboard=[UIStoryboard storyboardWithName:@"login" bundle:nil];
    LoginViewController *loginViewController=[loginStoryboard instantiateInitialViewController];
    //window设置根控制器
    self.window.rootViewController=loginViewController;
    //window显示
    [self.window makeKeyAndVisible];
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
