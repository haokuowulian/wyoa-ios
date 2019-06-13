//
//  KJJPushHelper.h
//  weijianlianxian
//
//  Created by apple on 2018/8/3.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface KJJPushHelper : NSObject
// 在应用启动的时候调用
+ (void)setupWithOption:(NSDictionary *)launchingOption
                 appKey:(NSString *)appKey
                channel:(NSString *)channel
       apsForProduction:(BOOL)isProduction
  advertisingIdentifier:(NSString *)advertisingId;

// 在appdelegate注册设备处调用
+ (void)registerDeviceToken:(NSData *)deviceToken;

// ios7以后，才有completion，否则传nil
+ (void)handleRemoteNotification:(NSDictionary *)userInfo completion:(void (^)(UIBackgroundFetchResult))completion;

// 显示本地通知在最前面
+ (void)showLocalNotificationAtFront:(UILocalNotification *)notification;

@end
