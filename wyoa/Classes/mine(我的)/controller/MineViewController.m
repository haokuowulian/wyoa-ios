//
//  MineViewController.m
//  wyoa
//
//  Created by apple on 2018/8/13.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "MineViewController.h"
#import "MyWalletViewController.h"
#import "UserInfoResultBean.h"
#import <MJExtension/MJExtension.h>
#import  "UIImageView+WebCache.h"
#import "PersonalInfoViewController.h"
@interface MineViewController ()
@property(nonatomic,strong) UserInfoResultBean *userInfoResultBean;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getUserInfo];
    
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice:) name:@"userInfoRefresh" object:nil];


}

#pragma mark 刷新用户信息
-(void)notice:(id)sender{
    [self getUserInfo];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"333333"],NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithHexString:@"333333"]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 获取用户信息
-(void)getUserInfo{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *userId=[userDefault objectForKey:@"userId"];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    NSDictionary *params=@{@"userId":userId
                           };
    NSString *url=[NSString stringWithFormat:@"%@?apikey=%@",@"oaCustom/getUserInfo.do",apikey];
    [UserInfoResultBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
      self.userInfoResultBean=[UserInfoResultBean mj_objectWithKeyValues:dict];
        if(self.userInfoResultBean.success==1){
              [self.headView   sd_setImageWithURL:self.userInfoResultBean.headPhoto placeholderImage:[UIImage   imageNamed:@"defaulthead"]];
            [self.realNameLabel setText:self.userInfoResultBean.realname];
            [self.userJobLabel setText:[NSString stringWithFormat:@"职务：%@",self.userInfoResultBean.userJob] ];
            
        }else{
           
        }
    } Error:^(NSError *err) {
    
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"personalInfo"])
    {
       PersonalInfoViewController *controller= segue.destinationViewController;
       controller.userInfoBean=self.userInfoResultBean;
        
    }
}
@end
