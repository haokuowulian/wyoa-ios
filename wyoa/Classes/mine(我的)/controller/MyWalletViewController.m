//
//  MyWalletViewController.m
//  wyoa
//
//  Created by apple on 2018/8/15.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "MyWalletViewController.h"
#import "MineViewController.h"
#import "WalletBean.h"
#import "MJExtension.h"
#import "MBProgressHUD+MBProgressHUD.h"
#import "Extern.h"
@interface MyWalletViewController ()

@end

@implementation MyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getMyWallet];
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

#pragma mark 获取我的钱包余额
-(void)getMyWallet{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *userId=[userDefault objectForKey:@"userId"];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
     NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"oaCustom/listMywallet.do",apikey];
    NSDictionary *params=@{@"userId":userId};
    [WalletBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
         WalletBean *walletBean=[WalletBean mj_objectWithKeyValues:dict];
        if(walletBean.success==1){
            [self.moneyLabel setText:walletBean.balance];
        }else{
            [MBProgressHUD showError:walletBean.message];
        }
    } Error:^(NSError *err) {
        [MBProgressHUD showError:@"网络连接失败"];
    }];
}




@end
