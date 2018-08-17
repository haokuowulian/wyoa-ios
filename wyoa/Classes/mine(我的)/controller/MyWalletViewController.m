//
//  MyWalletViewController.m
//  wyoa
//
//  Created by apple on 2018/8/15.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "MyWalletViewController.h"
#import "MineViewController.h"

@interface MyWalletViewController ()

@end

@implementation MyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"316FC9"]];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

}





@end
