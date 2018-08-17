//
//  ZJHKTabBarViewController.h
//  wjlx
//
//  Created by apple on 2018/7/11.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJHKTabBarbutton.h"

@interface ZJHKTabBarViewController : UITabBarController
@property(nonatomic,strong) UIView *tabbar;
- (void)changeViewController:(ZJHKTabBarbutton *)sender;
@end
