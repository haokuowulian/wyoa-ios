//
//  WorkViewController.m
//  wyoa
//
//  Created by apple on 2018/8/13.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "WorkViewController.h"
#import "OrderTabBarController.h"
#import "ShenPiViewController.h"
#import "QingJiaViewController.h"

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


- (IBAction)daiwoshenpiClick:(id)sender {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"ShenPi" bundle:nil];
    ShenPiViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"shenpi"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)shenpiClick:(id)sender {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"ShenPi" bundle:nil];
    ShenPiViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"shenpi"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)orderClick:(id)sender {
      self.hidesBottomBarWhenPushed=YES;
    OrderTabBarController *tabbarController=[[OrderTabBarController alloc]init];
    [self.navigationController pushViewController:tabbarController animated:YES];
         self.hidesBottomBarWhenPushed=NO;
}

- (IBAction)qingjiaClick:(id)sender {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"QingJia" bundle:nil];
    QingJiaViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"qingjia"];
    controller.title=@"请假";
    [self.navigationController pushViewController:controller animated:YES];
}
@end
