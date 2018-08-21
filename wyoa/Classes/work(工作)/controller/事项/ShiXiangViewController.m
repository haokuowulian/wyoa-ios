//
//  ShiXiangViewController.m
//  wyoa
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "ShiXiangViewController.h"
#import "QingJiaViewController.h"
#import "GongChaiViewController.h"
#import "TiaoBanViewController.h"
#import "LingYongViewController.h"
#import "BaoXiuViewController.h"
#import "ShenGouViewController.h"

@interface ShiXiangViewController ()

@end

@implementation ShiXiangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)qingjiaClick:(id)sender {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"QingJia" bundle:nil];
    QingJiaViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"qingjia"];
    controller.title=@"请假";
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)gongchaiClick:(id)sender {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"GongChai" bundle:nil];
    GongChaiViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"gongchai"];
    controller.title=@"公差";
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)tiaobanClick:(id)sender {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"TiaoBan" bundle:nil];
    TiaoBanViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"tiaoban"];
    controller.title=@"调班";
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)lingyongClick:(id)sender {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"LingYong" bundle:nil];
    TiaoBanViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"lingyong"];
    controller.title=@"物品领用";
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)baoxiuClick:(id)sender {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"BaoXiu" bundle:nil];
    TiaoBanViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"baoxiu"];
    controller.title=@"报修";
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)shengouClick:(id)sender {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"ShenGou" bundle:nil];
    TiaoBanViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"shengou"];
    controller.title=@"物品申购";
    [self.navigationController pushViewController:controller animated:YES];
}
@end
