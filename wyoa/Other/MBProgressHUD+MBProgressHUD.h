//
//  MBProgressHUD+MBProgressHUD.h
//  wyoa
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (MBProgressHUD)
+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;
@end
