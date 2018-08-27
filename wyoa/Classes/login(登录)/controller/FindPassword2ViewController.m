//
//  FindPassword2ViewController.m
//  wyoa
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "FindPassword2ViewController.h"
#import "MBProgressHUD+MBProgressHUD.h"
#import "BaseBean.h"
#import "MJExtension.h"
#import "JumpVCManager.h"
#import "ValidPassword.h"
#import "Extern.h"

@interface FindPassword2ViewController ()

@end

@implementation FindPassword2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.nowPasswordText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.againPasswordText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
     [self textFieldDidChange];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)completeClick:(id)sender {
    
    if([self checkIsEqual]){
        if([ValidPassword judgePassWordLegal:self.nowPasswordText.text]){//验证密码是否大于8个字符，且存在数字和字母
            [self updatePassword];
        }else{
            [MBProgressHUD showError:@"密码不合法"];
        }
       
    }else{
        [MBProgressHUD showError:@"两次密码输入不相同"];
    }
}

#pragma mark 监听文本内容变化，确定按钮是否可点击
-(void)textFieldDidChange{
    if(self.nowPasswordText.text.length>0&&self.againPasswordText.text.length>0){
        [self.completeButton setBackgroundColor:[UIColor colorWithHexString:@"1E82D2"]];
        [self.completeButton setEnabled:YES];
    }else{
        [self.completeButton setBackgroundColor:[UIColor lightGrayColor]];
        [self.completeButton setEnabled:NO];
    }
}

#pragma mark 检验两次密码输入是否相同
-(BOOL)checkIsEqual{
    if([self.nowPasswordText.text isEqualToString:self.againPasswordText.text]){
        return YES;
    }else{
        return NO;
    }
}

#pragma mark 重置密码
-(void)updatePassword{
    [MBProgressHUD showMessage:@"正在重置密码..."];
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
     NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@&telphone=%@&authCode=%@&password=%@",baseUrl,@"oamessage/forgetPassword.do",apikey,_telphone,_authCode,self.nowPasswordText.text];
    [BaseBean BeanByPostWithUrl:url Params:nil Success:^(NSDictionary *dict) {
        [MBProgressHUD hideHUD];
        BaseBean *resultBean=[BaseBean mj_objectWithKeyValues:dict];
        if(resultBean.success==1){
            [MBProgressHUD showSuccess:@"密码重置成功，请重新登入"];
            [[JumpVCManager shareInstance]backToRootVC];
            
        }else{
            [MBProgressHUD showError:resultBean.message];
        }
    } Error:^(NSError *err) {
         [MBProgressHUD showError:@"网络连接失败"];
         [MBProgressHUD hideHUD];
    }];
}
@end
