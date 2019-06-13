//
//  NewWorkViewController.m
//  wyoa
//
//  Created by apple on 2018/10/27.
//  Copyright © 2018 zjf. All rights reserved.
//

#import "NewWorkViewController.h"
#import "MyKaoQinViewController.h"
#import "QingJiaViewController.h"
#import "GongChaiViewController.h"
#import "TiaoBanViewController.h"
#import "LingYongViewController.h"
#import "BaoXiuViewController.h"
#import "ShenGouViewController.h"
#import "OrderTabBarController.h"
#import "FaQiViewController.h"
#import "ChaoSongViewController.h"
#import "ShenPiViewController.h"
#import "NumBean.h"
#import "Extern.h"
#import "MJExtension.h"
#import "MyOnDutyViewController.h"
@interface NewWorkViewController ()

@end

@implementation NewWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ChuQinMarginLeft.constant=(kScreenWidth-23*2-48*4)/3;
    self.TongZhiMarginLeft.constant=(kScreenWidth-23*2-48*4)/3;
    self.GongChaiMarginLeft.constant=(kScreenWidth-23*2-48*4)/3;
    self.TiaoBanMarginLeft.constant=(kScreenWidth-23*2-48*4)/3;
    self.ChaoSongMarginLeft.constant=(kScreenWidth-23*2-48*4)/3;
    self.ShenPiMarginLeft.constant=(kScreenWidth-23*2-48*4)/3;
    self.ShenGouMarginLeft.constant=(kScreenWidth-23*2-48*4)/3;
    self.DingDanMarginLeft.constant=(kScreenWidth-23*2-48*4)/3;
    
    [self getNum];
}


- (IBAction)daiwoshenpiClick:(id)sender {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"ShenPi" bundle:nil];
    ShenPiViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"shenpi"];
    controller.title=@"待我审批";
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)chuqinClick:(id)sender {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Mine" bundle:nil];
    MyKaoQinViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"kaoqin"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)shijiaClick:(id)sender {
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

- (IBAction)dingcanClick:(id)sender {
    self.hidesBottomBarWhenPushed=YES;
    OrderTabBarController *tabbarController=[[OrderTabBarController alloc]init];
    [self.navigationController pushViewController:tabbarController animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

- (IBAction)faqiClick:(id)sender {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"FaQi" bundle:nil];
    FaQiViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"faqi"];
    controller.title=@"我发起的";
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)chaosongClick:(id)sender {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"ChaoSong" bundle:nil];
    ChaoSongViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"chaosong"];
    controller.title=@"抄送我的";
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)shenpiClick:(id)sender {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"ShenPi" bundle:nil];
    ShenPiViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"shenpi"];
    controller.title=@"待我审批";
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

- (IBAction)zhibanClick:(id)sender {
     self.hidesBottomBarWhenPushed=YES;// 进入
    MyOnDutyViewController *controller=[[MyOnDutyViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
     self.hidesBottomBarWhenPushed=NO;//tuichu
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
