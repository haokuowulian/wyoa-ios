//
//  LoginViewController.m
//  wyoa
//
//  Created by apple on 2018/8/13.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "LoginViewController.h"
#import "ZJHKTabBarViewController.h"
#import "LoginResultBean.h"
#import "MJExtension.h"
#import "MBProgressHUD+MBProgressHUD.h"
#import "Extern.h"
#import "RoleBean.h"
#import <JPUSHService.h>
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=NO;
    // 设置导航控制器的代理为self
    self.navigationController.delegate = self;
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [self.userNameText setText:[userDefault objectForKey:@"loginName"]];
    [self.passwordText setText:[userDefault objectForKey:@"password"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    self.navigationController.navigationBar.hidden=YES;
}
#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}
- (IBAction)loginClick:(id)sender {
    if(![self isEmpty]){
//        ZJHKTabBarViewController *tabbarController=[[ZJHKTabBarViewController alloc]init];
//        [self presentViewController:tabbarController animated:YES completion:^{
//        }];
        [self login];
    }else{
         [MBProgressHUD showError:@"用户名或密码不能为空" toView:self.navigationController.view];
    }
}

#pragma mark 判断用户名密码是否填写完整
-(Boolean)isEmpty{
    if(_userNameText.text.length>0&&_passwordText.text.length>0){
        return NO;
    }else{
        return YES;
    }
}

#pragma mark 请求登录
-(void)login{
    [MBProgressHUD showMessage:@"正在登录中..."];
    NSDictionary *params=@{@"userName":_userNameText.text,
                           @"password":_passwordText.text
                           };
    NSString *url=[NSString stringWithFormat:@"%@%@",baseUrl,@"oaCustom/loginByPassword.do"];
    [LoginResultBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
        [MBProgressHUD hideHUD];
        LoginResultBean *resultBean=[LoginResultBean mj_objectWithKeyValues:dict];
        if(resultBean.success==1){
            NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
            [userDefault setObject:resultBean.userId forKey:@"userId"];
            [userDefault setObject:self.userNameText.text forKey:@"loginName"];
            [userDefault setObject:self.passwordText.text forKey:@"password"];
            [userDefault setObject:resultBean.apikey forKey:@"apikey"];
            [userDefault synchronize];
            [self getRowId:resultBean.userId andApikey:resultBean.apikey];
            NSSet *set= [NSSet setWithObjects:resultBean.userId,nil];
            
            [JPUSHService setTags:set completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
                if(iResCode==0){
                    NSLog(@"设置成功");
                }
            } seq:0];
  
        }else{
             [MBProgressHUD showError:@"用户名账号或密码错误"];
            [MBProgressHUD hideHUD];
            
            }
    } Error:^(NSError *err) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"网络连接失败"];
    }];
}

-(void)getRowId:(NSString *)userId andApikey:(NSString *)apikey{
    NSDictionary *params=@{@"userId":userId
                           };
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"oaCustom/getAppMenuList.do",apikey];
    [RoleBean BeanByPostWithUrl:url  Params:params Success:^(NSDictionary *dict) {
        RoleBean *roleBean=[RoleBean mj_objectWithKeyValues:dict];
        if(roleBean.success==1){
            NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
            [userDefault setObject:roleBean.roleId forKey:@"roleId"];
            [userDefault synchronize];
            ZJHKTabBarViewController *tabbarController=[[ZJHKTabBarViewController alloc]init];
            [self presentViewController:tabbarController animated:YES completion:^{
                
            }];
        }
    } Error:^(NSError *err) {
        
    }];
    
}
@end
