//
//  ZJHKNavigationViewController.m
//  wjlx
//
//  Created by apple on 2018/7/11.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "ZJHKNavigationViewController.h"

@interface ZJHKNavigationViewController ()

@end

@implementation ZJHKNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"333333"],NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}];
    [self.navigationBar setTintColor:[UIColor colorWithHexString:@"333333"]];
   
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
