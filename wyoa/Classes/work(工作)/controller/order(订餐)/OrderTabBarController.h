//
//  OrderTabBarController.h
//  wyoa
//
//  Created by apple on 2018/8/19.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJHKTabBarbutton.h"
@interface OrderTabBarController : UITabBarController
@property(nonatomic,strong) UIView *tabbar;
- (void)changeViewController:(ZJHKTabBarbutton *)sender;
@end
