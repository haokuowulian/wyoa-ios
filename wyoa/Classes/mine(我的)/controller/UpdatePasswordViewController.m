//
//  UpdatePasswordViewController.m
//  wyoa
//
//  Created by apple on 2018/8/18.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "UpdatePasswordViewController.h"
#import "MBProgressHUD+MBProgressHUD.h"
#import "ValidPassword.h"
#import "BaseBean.h"
#import <MJExtension/MJExtension.h>
#import "LoginViewController.h"
#import "JumpVCManager.h"
@interface UpdatePasswordViewController ()

@end

@implementation UpdatePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.oldPasswordText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.nowPasswordText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.againPasswordText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
   
    
     UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:(UIBarButtonItemStyleDone) target:self action:@selector(confirm)];
     self.navigationItem.rightBarButtonItem = rightitem;
    
    [self textFieldDidChange];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)confirm{
    if([self isTwiceEqual]){
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
 if(self.oldPasswordText.text.length>0&&self.nowPasswordText.text.length>0&&self.againPasswordText.text.length>0){
        [self.navigationItem.rightBarButtonItem setTintColor:kThemeColor];
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
    }else{
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
    }
}

#pragma mark 验证两次密码是否相同
-(Boolean)isTwiceEqual{
    if([self.nowPasswordText.text isEqualToString:self.againPasswordText.text]){
        return YES;
    }else{
        return NO;
    }
}

#pragma mark 修改密码
-(void)updatePassword{
    [MBProgressHUD showMessage:@"正在修改密码..."];
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *userId=[userDefault objectForKey:@"userId"];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    NSDictionary *params=@{@"userId":userId,
                           @"oldPass":self.oldPasswordText.text,
                           @"newPass":self.nowPasswordText.text
                           };
    NSString *url=[NSString stringWithFormat:@"%@?apikey=%@",@"oaCustom/updatePassword.do",apikey];
    [BaseBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
        [MBProgressHUD hideHUD];
        BaseBean *resultBean=[BaseBean mj_objectWithKeyValues:dict];
        if(resultBean.success==1){
            [MBProgressHUD showSuccess:@"密码修改成功,请重新登录"];
            [[JumpVCManager shareInstance]backToRootVC];
            
        }else{
            [MBProgressHUD showError:resultBean.message];
        }
    } Error:^(NSError *err) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"网络连接失败"];
    }];
}
@end
