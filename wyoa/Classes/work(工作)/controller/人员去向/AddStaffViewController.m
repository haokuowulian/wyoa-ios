//
//  AddStaffViewController.m
//  wyoa
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "AddStaffViewController.h"
#import "MailListViewController.h"
#import "WYBirthdayPickerView.h"
#import "ContactBean.h"
#import "BaseBean.h"
#import "MBProgressHUD+MBProgressHUD.h"
#import "Extern.h"
#import "MJExtension.h"

@interface AddStaffViewController ()
@property(nonatomic,copy)NSString *userinfoId;
@end

@implementation AddStaffViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(selectUser:) name:@"selectUser" object:nil];
    if(self.staffDetailBean){
        self.userinfoId=self.staffDetailBean.userinfoId;
        [self.nameLabel setText:self.staffDetailBean.name];
        [self.startDateLabel setText:self.staffDetailBean.startDate];
        [self.endDateLabel setText:self.staffDetailBean.endDate];
        [self.quxiangLabel setText:self.staffDetailBean.location];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark 获取换班人信息
-(void)selectUser:(id)sender{
    ContactBean *bean=[sender object];
    [self.nameLabel setText:bean.name];
    self.userinfoId=bean.id;
}

- (IBAction)nameClick:(id)sender {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"MailList" bundle:nil];
    MailListViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"mailList"];
    controller.isFromSelect=YES;
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)startDateClick:(id)sender {
     [self selectDateTime:self.startDateLabel];
}
- (IBAction)endDateClick:(id)sender {
     [self selectDateTime:self.endDateLabel];
}
- (IBAction)submitClick:(id)sender {
    if( [self checkIsEmpty]){
        if(self.indexPath&&self.staffDetailBean){
          [self update];
        }else{
          [self submit];
        }
    }else{
        [MBProgressHUD showError:@"请检查信息是否填写完整"];
    }
}
#pragma mark 验证信息是否填写完整
-(BOOL)checkIsEmpty{
    if(self.nameLabel.text.length>0&&
       self.startDateLabel.text.length>0&&
       self.endDateLabel.text.length>0&&
       self.quxiangLabel.text.length>0){
        return YES;
    }else{
        return NO;
    }
}
#pragma mark 时间选择
-(void)selectDateTime:(UITextField *)textField{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    dateFormatter.dateFormat=@"yyyy-MM-dd";
    WYBirthdayPickerView *datePickerView = [[WYBirthdayPickerView alloc] initWithInitialDate:[dateFormatter stringFromDate:[NSDate date]] andDateFormatter:@"yyyy-MM-dd"];
    // 选择日期完成之后的回调 : 按自己的要求做相应的处理就可以了
    datePickerView.confirmBlock = ^(NSString *selectedDate) {
        textField.text=selectedDate;
        
    };
    
    [self.view addSubview:datePickerView];
}

#pragma mark 新增去向
-(void)submit{
    [MBProgressHUD showMessage:@"正在提交..."];
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"noteNew/addUserLocal.do",apikey];
    NSDictionary *params=@{@"userinfoId":self.userinfoId,
                           @"startDate":self.startDateLabel.text,
                           @"endDate":self.endDateLabel.text,
                           @"location":self.quxiangLabel.text
                           };
    [BaseBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
        [MBProgressHUD hideHUD];
         BaseBean *basebean=[BaseBean mj_objectWithKeyValues:dict];
        if(basebean.success==1){
            [MBProgressHUD showSuccess:@"新增成功"];
            [self.navigationController popViewControllerAnimated:YES];
            //创建一个消息对象
            NSNotification * notice = [NSNotification notificationWithName:@"staffRefresh" object:nil];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
        }else{
            [MBProgressHUD showError:basebean.message];
        }
    } Error:^(NSError *err) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"网络连接失败"];
    }];
}

#pragma mark 修改去向
-(void)update{
    [MBProgressHUD showMessage:@"正在修改..."];
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *userId=[userDefault objectForKey:@"userId"];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"noteNew/editUserLocal.do",apikey];
    NSDictionary *params=@{@"id":self.staffDetailBean.id,
                           @"userId":userId,
                           @"userinfoId":self.userinfoId,
                           @"startDate":self.startDateLabel.text,
                           @"endDate":self.endDateLabel.text,
                           @"location":self.quxiangLabel.text
                           };
    [BaseBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
        [MBProgressHUD hideHUD];
        BaseBean *basebean=[BaseBean mj_objectWithKeyValues:dict];
        if(basebean.success==1){
            [MBProgressHUD showSuccess:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
            //创建一个消息对象
            NSNotification * notice = [NSNotification notificationWithName:@"staffRefresh" object:nil];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
        }else{
            [MBProgressHUD showError:basebean.message];
        }
    } Error:^(NSError *err) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"网络连接失败"];
    }];
}

@end
