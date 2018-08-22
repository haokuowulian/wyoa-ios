//
//  FindPassword1ViewController.m
//  wyoa
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "FindPassword1ViewController.h"
#import "MBProgressHUD+MBProgressHUD.h"
#import "BaseBean.h"
#import <MJExtension/MJExtension.h>
#import "FindPassword2ViewController.h"
#import "Extern.h"
@interface FindPassword1ViewController ()

@end

@implementation FindPassword1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.errorCodeLabel.hidden=YES;
    self.navigationController.navigationBar.hidden=NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
     [self.navigationController.navigationBar setTintColor:[UIColor colorWithHexString:@"333333"]];
    
    [self.telPhoneText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.codeText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self textFieldDidChange];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)getCodeClick:(id)sender {
    if([self checkPhoneNum]){
        [self getCode];
    }else{
        [MBProgressHUD showError:@"请检查手机号是否正确"];
    }
    
}
- (IBAction)nextStepClick:(id)sender {
    [self checkCodeIsCorrect];
}

#pragma mark 监听文本内容变化，确定按钮是否可点击
-(void)textFieldDidChange{
    if(self.telPhoneText.text.length>0&&self.codeText.text.length>0){
        [self.nextStepButton setBackgroundColor:[UIColor colorWithHexString:@"1E82D2"]];
        [self.nextStepButton setEnabled:YES];
    }else{
        [self.nextStepButton setBackgroundColor:[UIColor lightGrayColor]];
        [self.nextStepButton setEnabled:NO];
    }
}

#pragma mark 验证手机号是否合法
-(Boolean)checkPhoneNum{
    NSString *regex = @"^((13[0-9])|(14[5,7,9])|(15[^4])|(18[0-9])|(17[0,1,3,5,6,7,8]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self.telPhoneText.text];
    if (!isMatch){
        return NO;
    }
    return YES;
}

#pragma mark 获取验证码
-(void)getCode{
     [MBProgressHUD showMessage:@"正在获取验证码..."];
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
 
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@&telphone=%@",baseUrl,@"oamessage/getResetVerfiyCode.do",apikey,self.telPhoneText.text];
        [BaseBean BeanByPostWithUrl:url Params:nil Success:^(NSDictionary *dict) {
         [MBProgressHUD hideHUD];
        BaseBean *resultBean=[BaseBean mj_objectWithKeyValues:dict];
        if(resultBean.success==1){
            [self startTime];
        }else{
           [MBProgressHUD showError:resultBean.message];
        }
    } Error:^(NSError *err) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"网络连接失败"];
    }];
}
#pragma mark ----------利用GCD实现倒计时----------
-(void)startTime{
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.getCodeButton.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.getCodeButton setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                self.getCodeButton.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(timer);
    
}

#pragma mark 校验验证码是否正确
-(void)checkCodeIsCorrect{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@&telphone=%@&authCode=%@",baseUrl,@"oamessage/codeCheck.do",apikey,self.telPhoneText.text,self.codeText.text];
    [BaseBean BeanByPostWithUrl:url Params:nil Success:^(NSDictionary *dict) {
        BaseBean *resultBean=[BaseBean mj_objectWithKeyValues:dict];
        if(resultBean.success==1){
            self.errorCodeLabel.hidden=YES;
            UIStoryboard *board=[UIStoryboard storyboardWithName:@"FindPassword2View" bundle:nil];
            FindPassword2ViewController *controller=[board instantiateViewControllerWithIdentifier:@"findPassword2"];
            controller.authCode=self.codeText.text;
            controller.telphone=self.telPhoneText.text;
            [self.navigationController pushViewController:controller animated:YES];
            
        }else{
           self.errorCodeLabel.hidden=NO;
        }
    } Error:^(NSError *err) {
       
    }];
}
@end
