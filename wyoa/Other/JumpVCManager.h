//
//  JumpVCManager.h
//  wjlx
//
//  Created by apple on 2018/7/21.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, AnimationType) {
    AnimationTypeBottom,
    AnimationTypeLeft,
};
@interface JumpVCManager : NSObject
+ (instancetype)shareInstance;
- (void)backToRootVCAnimation:(AnimationType)type;
- (void)backToRootVC;
- (UIViewController *)visibleVC;
@property (nonatomic) BOOL isJumping;// 是否正在跳转
@end
