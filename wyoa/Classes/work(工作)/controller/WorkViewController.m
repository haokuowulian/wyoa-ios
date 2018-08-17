//
//  WorkViewController.m
//  wyoa
//
//  Created by apple on 2018/8/13.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "WorkViewController.h"

@interface WorkViewController ()

@end

@implementation WorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"------%f",kScreenWidth);
    self.chuqinViewMarginLeft.constant=(kScreenWidth-23*2-48*4)/3;
    self.qingjiaViewMarginLeft.constant=(kScreenWidth-23*2-48*4)/3;
    self.shenpiViewMarginLeft.constant=(kScreenWidth-23*2-48*4)/3;
    self.kaoqinViewMarginLeft.constant=(kScreenWidth-23*2-48*4)/3;
    self.guanliViewMarginLeft.constant=(kScreenWidth-23*2-48*4)/3;
    self.shenqingViewMarginLeft.constant=(kScreenWidth-23*2-48*4)/3;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
