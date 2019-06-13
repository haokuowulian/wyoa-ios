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
#import "OrderManageViewController.h"
#import "MBProgressHUD+MBProgressHUD.h"
#import "NumBean.h"
#import "Extern.h"
#import "MJExtension.h"
#import "MyKaoQinViewController.h"
@interface WorkViewController ()

@end

@implementation WorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"------%f",kScreenWidth);
    self.chuqinViewMarginLeft.constant=(kScreenWidth-23*2-48*4)/3;
    self.qingjiaViewMarginLeft.constant=(kScreenWidth-23*2-48*4)/3;
    self.shenpiViewMarginLeft.constant=(kScreenWidth-23*2-48*4)/3;
    self.dingcanViewMarginLeft.constant=(kScreenWidth-23*2-48*4)/3;
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(numRefresh) name:@"numRefresh" object:nil];

    [self getNum];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)numRefresh{
    [self getNum];
}

- (IBAction)chuqinClick:(id)sender {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Mine" bundle:nil];
    MyKaoQinViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"kaoqin"];
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

- (IBAction)dingdanManageClick:(id)sender {
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *roleId=[userDefault objectForKey:@"roleId"];
    if([roleId isEqualToString:@"1"]||
       [roleId isEqualToString:@"9"]||
       [roleId isEqualToString:@"10"]||
       [roleId isEqualToString:@"11"]||
       [roleId isEqualToString:@"12"]||
       [roleId isEqualToString:@"13"]||
       [roleId isEqualToString:@"14"]){
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Work" bundle:nil];
        OrderManageViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"orderManage"];
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        [MBProgressHUD showError:@"您无权查看此功能"];
    }
   
}
//获取我的出勤天数和和待审批申请数量

-(void)getNum{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
        NSString *userId=[userDefault objectForKey:@"userId"];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"oaCustom/getAppSomeCount.do",apikey];
    NSDictionary *params=@{@"userId":userId};
    [NumBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
         NumBean *resultBean=[NumBean mj_objectWithKeyValues:dict];
        if(resultBean.success==1){
            [self.daiwoshenpiNumButton setTitle:resultBean.pendCount forState:UIControlStateNormal];
            [self.chuqinNumButton setTitle:resultBean.factAttendDay forState:UIControlStateNormal];
        }else{
            [self.daiwoshenpiNumButton setTitle:@"0" forState:UIControlStateNormal];
            [self.chuqinNumButton setTitle:@"0" forState:UIControlStateNormal];
        }
    } Error:^(NSError *err) {
        [self.daiwoshenpiNumButton setTitle:@"0" forState:UIControlStateNormal];
        [self.chuqinNumButton setTitle:@"0" forState:UIControlStateNormal];
    }];
}
@end
