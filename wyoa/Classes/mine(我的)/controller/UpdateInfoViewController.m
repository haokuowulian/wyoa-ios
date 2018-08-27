//
//  UpdateInfoViewController.m
//  wyoa
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "UpdateInfoViewController.h"
#import "MBProgressHUD+MBProgressHUD.h"
#import "UserInfoResultBean.h"
#import "MJExtension.h"
#import "WYGenderPickerView.h"
#import "WYBirthdayPickerView.h"
#import "Extern.h"

@interface UpdateInfoViewController ()

@end

@implementation UpdateInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self.infoText setPlaceholder:_placeholder];
    [self.infoText setText:_text];
    [self.infoText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:(UIBarButtonItemStyleDone) target:self action:@selector(confirm)];
    self.navigationItem.rightBarButtonItem = rightitem;
    if(self.infoText.text.length>0){
    [self.navigationItem.rightBarButtonItem setTintColor:kThemeColor];
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
    }else{
         [self.navigationItem.rightBarButtonItem setEnabled:NO];
    }

    if([self.placeholder isEqualToString:@"请填写真实姓名"]){
         self.button.hidden=YES;
    }else if([self.placeholder isEqualToString:@"请选择性别"]){
         self.button.hidden=NO;
    }else if([self.placeholder isEqualToString:@"请选择出生日期"]){
         self.button.hidden=NO;
    }else if([self.placeholder isEqualToString:@"请填写手机短号"]){
        self.button.hidden=YES;
    }else if([self.placeholder isEqualToString:@"请填写手机长号"]){
         self.button.hidden=YES;
    }else if([self.placeholder isEqualToString:@"请填写QQ号"]){
        self.button.hidden=YES;
    }else if([self.placeholder isEqualToString:@"请填写微信号"]){
       self.button.hidden=YES;
    }
//    else if([self.placeholder isEqualToString:@"请选择所在科室"]){
//        self.button.hidden=NO;
//    }else if([self.placeholder isEqualToString:@"请填写所在科室电话"]){
//         self.button.hidden=YES;
//    }else if([self.placeholder isEqualToString:@"请填写担任职务"]){
//         self.button.hidden=YES;
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)confirm{
    [self updateUserInfo];
}
#pragma mark 监听文本变化改变按钮
-(void)textFieldDidChange :(UITextField *)theTextField{
    if(self.infoText.text.length>0){
        [self.navigationItem.rightBarButtonItem setTintColor:kThemeColor];
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
    }else{
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
    }
}

#pragma mark 修改信息
-(void)updateUserInfo{
    [MBProgressHUD showMessage:@"正在修改信息..."];
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
     NSString *userId=[userDefault objectForKey:@"userId"];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    self.userInfoBean.userId=userId;
//    if([self.placeholder isEqualToString:@"请填写用户名"]){
//        self.userInfoBean.userName=self.infoText.text;
//    }else
    if([self.placeholder isEqualToString:@"请填写真实姓名"]){
        self.userInfoBean.realname=self.infoText.text;
    }else if([self.placeholder isEqualToString:@"请选择性别"]){
         self.userInfoBean.sex=self.infoText.text;
    }else if([self.placeholder isEqualToString:@"请选择出生日期"]){
         self.userInfoBean.birthday=self.infoText.text;
    }else if([self.placeholder isEqualToString:@"请填写手机短号"]){
         self.userInfoBean.mobilePhone=self.infoText.text;
    }else if([self.placeholder isEqualToString:@"请填写手机长号"]){
         self.userInfoBean.telPhone=self.infoText.text;
    }else if([self.placeholder isEqualToString:@"请填写QQ号"]){
         self.userInfoBean.qq=self.infoText.text;
    }else if([self.placeholder isEqualToString:@"请填写微信号"]){
         self.userInfoBean.weChat=self.infoText.text;
    }
//    else if([self.placeholder isEqualToString:@"请选择所在科室"]){
//         self.userInfoBean.userSecition=self.infoText.text;
//    }else if([self.placeholder isEqualToString:@"请填写所在科室电话"]){
//         self.userInfoBean.sectionPhone=self.infoText.text;
//    }else if([self.placeholder isEqualToString:@"请填写担任职务"]){
//         self.userInfoBean.userJob=self.infoText.text;
//    }

    NSDictionary *params = self.userInfoBean.mj_keyValuesWithAll;
  
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"oaCustom/updateUserInfo.do",apikey];
    [BaseBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
        [MBProgressHUD hideHUD];
        BaseBean *resultBean=[BaseBean mj_objectWithKeyValues:dict];
        if(resultBean.success==1){
            [MBProgressHUD showSuccess:@"信息修改成功"];
            //创建一个消息对象
            NSNotification * notice = [NSNotification notificationWithName:@"userInfoRefresh" object:nil];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
            
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:resultBean.message];
        }
    } Error:^(NSError *err) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"网络连接失败"];
    }];
}
- (IBAction)buttonClick:(id)sender {
   if([self.placeholder isEqualToString:@"请选择性别"]){
       [self selectSex];
   }else if([self.placeholder isEqualToString:@"请选择出生日期"]){
        [self selectBirthday];
   }
}

#pragma mark 选择性别
-(void)selectSex{
    // initialGender 参数 : genderPickerView 初始化显示时要显示的性别
    WYGenderPickerView *genderPickerView = [[WYGenderPickerView alloc] initWithInitialGender:self.infoText.text];
    
    // 选择性别完成之后的回调 : 按自己的要求做相应的处理就可以了
    genderPickerView.confirmBlock = ^(NSString *selectedGender) {
        
        self.infoText.text = selectedGender;
        
    };
    
    [self.view addSubview:genderPickerView];
}
#pragma mark 选择出生日期
-(void)selectBirthday{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    dateFormatter.dateFormat=@"yyyy-MM-dd";
    WYBirthdayPickerView *datePickerView = [[WYBirthdayPickerView alloc] initWithInitialDate:[dateFormatter stringFromDate:[NSDate date]]];
    // 选择日期完成之后的回调 : 按自己的要求做相应的处理就可以了
    datePickerView.confirmBlock = ^(NSString *selectedDate) {
        self.infoText.text=selectedDate;
        
    };
    
    [self.view addSubview:datePickerView];
}
@end
