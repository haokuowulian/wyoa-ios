//
//  JumpVCManager.m
//  wjlx
//
//  Created by apple on 2018/7/21.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "JumpVCManager.h"


@implementation JumpVCManager

+ (instancetype)shareInstance{
    static JumpVCManager *_shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[self alloc] init];
    });
    return _shareInstance;
}

- (UIViewController *)rootVC{
    UIViewController *rootViewcontroller = [[[[UIApplication  sharedApplication] delegate] window] rootViewController];
    UIViewController *rootVC = rootViewcontroller;
    if ([rootViewcontroller isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabVC =  (UITabBarController*)rootViewcontroller;
        if ([tabVC.selectedViewController isKindOfClass:[UINavigationController class]]) {
            rootVC = [(UINavigationController*)(tabVC.selectedViewController) viewControllers][0];
        } else {
            rootVC = tabVC.selectedViewController;
        }
    } else if ([rootViewcontroller isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav =  (UINavigationController *)rootViewcontroller;
        rootVC = nav.viewControllers[0];
    }
    return rootVC;
}


- (void)backToRootVCAnimation:(AnimationType)type{
    [self addAnimationWithType:type];
    [self backToRootVC];
}

- (void)addAnimationWithType:(AnimationType)type{
    CATransition *animation = [CATransition animation];
    //动画时间
    animation.duration = 0.25f;
    //过滤效果
    animation.type = kCATransitionReveal;
    //动画执行完毕时是否被移除
    animation.removedOnCompletion = YES;
    animation.subtype = kCATransitionFromBottom;
    if (type == AnimationTypeLeft) {
        animation.subtype = kCATransitionFromLeft;
    }
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:nil];
}

- (void)backToRootVC{
    if (self.isJumping == NO) {
        self.isJumping = YES;
        NSLog(@"start");
        [self backToRootViewController];
    }
}

- (void)backToRootViewController{
    NSLog(@"bbbbbbbbbbbbbbb");
    UIViewController* vc = [self visibleVC];
    if ([vc isEqual:self.rootVC]) {
        NSLog(@"end");
        self.isJumping = NO;
        return;
    }
    if (vc.presentingViewController) {
        while (vc.presentingViewController) {
            vc = vc.presentingViewController;
        }
        [vc dismissViewControllerAnimated:NO completion:^{
            [self backToRootViewController];
        }];
    } else{
         [vc.navigationController popToRootViewControllerAnimated:NO];
        
       
        [self backToRootViewController];
    }
}


- (UIViewController *)visibleVC{
    UIViewController *rootViewController =[[[[UIApplication sharedApplication] delegate] window] rootViewController];
    return [JumpVCManager                getVisibleViewControllerFrom:rootViewController];
}

+ (UIViewController *) getVisibleViewControllerFrom:(UIViewController *) vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [JumpVCManager getVisibleViewControllerFrom:[((UINavigationController *) vc) visibleViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [JumpVCManager getVisibleViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
    } else {
        if (vc.presentedViewController) {
            return [JumpVCManager getVisibleViewControllerFrom:vc.presentedViewController];
        } else {
            return vc;
        }
    }
}

@end
