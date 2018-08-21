//
//  PersonalInfoViewController.m
//  wyoa
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "UserInfoResultBean.h"
#import <MJExtension/MJExtension.h>
#import  "UIImageView+WebCache.h"
#import "MBProgressHUD+MBProgressHUD.h"
#import "UpdateInfoViewController.h"
@interface PersonalInfoViewController ()

@end

@implementation PersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self setUserInfo];
    
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice:) name:@"userInfoRefresh" object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 刷新用户信息
-(void)notice:(id)sender{
    [self getUserInfo];
}


#pragma mark set用户信息
-(void)setUserInfo{
    [self.headView   sd_setImageWithURL:self.userInfoBean.headPhoto placeholderImage:[UIImage   imageNamed:@"defaulthead"]];
    [self.userNameLabel setText:self.userInfoBean.userName];
    [self.realNameLabel setText:self.userInfoBean.realname];
    [self.sexLabel setText:self.userInfoBean.sex];
    [self.birthdayLabel setText:self.userInfoBean.birthday];
    [self.mobilePhoneLabel setText:self.userInfoBean.mobilePhone];
    [self.telPhoneLabel setText:self.userInfoBean.telPhone];
    [self.qqLabel setText:self.userInfoBean.qq];
    [self.wxLabel setText:self.userInfoBean.weChat];
    [self.sectionLabel setText:self.userInfoBean.userSecition];
    [self.sectionTelLabel setText:self.userInfoBean.sectionPhone];
    [self.userJobLbel setText:self.userInfoBean.userJob];
}

#pragma mark 获取用户信息
-(void)getUserInfo{
      [MBProgressHUD showMessage:@"正在获取信息..." toView:self.navigationController.view];
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *userId=[userDefault objectForKey:@"userId"];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    NSDictionary *params=@{@"userId":userId};
    NSString *url=[NSString stringWithFormat:@"%@?apikey=%@",@"oaCustom/getUserInfo.do",apikey];
    [UserInfoResultBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
        [MBProgressHUD hideHUDForView:self.navigationController.view];
        UserInfoResultBean *resultBean=[UserInfoResultBean mj_objectWithKeyValues:dict];
        self.userInfoBean=resultBean;
        if(resultBean.success==1){
            [self.headView   sd_setImageWithURL:resultBean.headPhoto placeholderImage:[UIImage   imageNamed:@"defaulthead"]];
            [self.userNameLabel setText:resultBean.userName];
            [self.realNameLabel setText:resultBean.realname];
            [self.sexLabel setText:resultBean.sex];
            [self.birthdayLabel setText:resultBean.birthday];
            [self.mobilePhoneLabel setText:resultBean.mobilePhone];
            [self.telPhoneLabel setText:resultBean.telPhone];
            [self.qqLabel setText:resultBean.qq];
            [self.wxLabel setText:resultBean.weChat];
            [self.sectionLabel setText:resultBean.userSecition];
            [self.sectionTelLabel setText:resultBean.sectionPhone];
            [self.userJobLbel setText:resultBean.userJob];

        }else{
            [MBProgressHUD showError:resultBean.message toView:self.navigationController.view];
        }
    } Error:^(NSError *err) {
         [MBProgressHUD hideHUDForView:self.navigationController.view];
        [MBProgressHUD showError:@"网络连接失败" toView:self.navigationController.view];
    }];
}

- (IBAction)userNameClick:(id)sender {
    [MBProgressHUD showError:@"用户名无法修改"];
}

- (IBAction)sectionClick:(id)sender {
    [MBProgressHUD showError:@"所在科室无法修改"];
}

- (IBAction)sectionTelClick:(id)sender {
     [MBProgressHUD showError:@"科室电话无法修改"];
}

- (IBAction)userjobClick:(id)sender {
     [MBProgressHUD showError:@"担任职务无法修改"];
}
#pragma mark 更换头像
- (IBAction)headViewClick:(id)sender {
    UIButton *button; // the button you want to show the popup sheet from
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"选择本地图片"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction *action) {
                                                            [self readImageFromAlbum];
                                                        }];
    UIAlertAction *otherAction2 = [UIAlertAction actionWithTitle:@"拍照"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
                                                             [self readImageFromCamera];
                                                         }];
    UIAlertAction *destroyAction = [UIAlertAction actionWithTitle:@"取消"
                                                            style:UIAlertActionStyleDestructive
                                                          handler:^(UIAlertAction *action) {
                                                              // do destructive stuff here
                                                          }];
    [alertController addAction:otherAction];
    [alertController addAction:otherAction2];
    [alertController addAction:destroyAction];
    [alertController setModalPresentationStyle:UIModalPresentationPopover];
    
    UIPopoverPresentationController *popPresenter = [alertController
                                                     popoverPresentationController];
    popPresenter.sourceView = button;
    popPresenter.sourceRect = button.bounds;
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma  mark 从相册中读取

- (void)readImageFromAlbum {
    
    //创建对象
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    //（选择类型）表示仅仅从相册中选取照片
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    //指定代理，因此我们要实现UIImagePickerControllerDelegate,                                                 UINavigationControllerDelegate协议
    
    imagePicker.delegate = self;
    
    //设置在相册选完照片后，是否跳到编辑模式进行图片剪裁。(允许用户编辑)
    
    imagePicker.allowsEditing = YES;
    
    //显示相册
    
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}



#pragma mark 实现拍照功能
- (void)readImageFromCamera {
    
    if ([UIImagePickerController isSourceTypeAvailable:                                           UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        imagePicker.delegate = self;
        
        imagePicker.allowsEditing = YES;
        
        //允许用户编辑
        
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    } else {
        
        //弹出窗口响应点击事件
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告"                         message:@"未检测到摄像头" delegate:nil cancelButtonTitle:nil                                                 otherButtonTitles:@"确定", nil];
        
        [alert show];
        
    }
    
}

#pragma mark 图片完成之后处理

- (void)imagePickerController:(UIImagePickerController *)picker        didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
    
    //上传到服务器
    [self uploadImageHeadWithImag:image];
    //结束操作
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark 上传头像
-(void)uploadImageHeadWithImag:(UIImage *)imageHead{
    [MBProgressHUD showMessage:@"正在上传头像..." toView:self.navigationController.view];
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSData *data = UIImageJPEGRepresentation(imageHead, 1.0f);
    NSString *userId=[userDefault objectForKey:@"userId"];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    NSString *url=[NSString stringWithFormat:@"%@?apikey=%@",@"oaCustom/updateUserHeadPhoto.do",apikey];
    NSString *picBody = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *picName=[NSString stringWithFormat:@"%@-%@2.png",[self getNowTimeTimestamp],userId];
    NSDictionary *params=@{@"userId":userId,
                           @"picBody":picBody,
                           @"picName":picName
                           };
    [BaseBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
        [MBProgressHUD hideHUDForView:self.navigationController.view ];
        BaseBean *resultBean=[BaseBean mj_objectWithKeyValues:dict];
        if(resultBean.success==1){
             [MBProgressHUD showSuccess:@"头像修改成功" toView:self.navigationController.view];
            //将图片添加到对应的视图上
            [self.headView setImage:imageHead];
            //创建一个消息对象
            NSNotification * notice = [NSNotification notificationWithName:@"userInfoRefresh" object:nil];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
        }else{
              [MBProgressHUD showError:[NSString stringWithFormat:@"头像修改失败,%@",resultBean.message] toView:self.navigationController.view];
        }
    } Error:^(NSError *err) {
        [MBProgressHUD hideHUDForView:self.navigationController.view ];
        [MBProgressHUD showError:@"网络连接失败" toView:self.navigationController.view];
    }];
  
    
    
}

#pragma  mark 获取当前时间戳
-(NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    
    return timeSp;
}



 #pragma mark - Navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
      UpdateInfoViewController *controller = segue.destinationViewController;
     controller.userInfoBean=self.userInfoBean;
     if ([segue.identifier isEqualToString:@"realName"]) {
         controller.text=self.realNameLabel.text;
         controller.placeholder=@"请填写真实姓名";
         controller.title=@"真实姓名";
     }else if ([segue.identifier isEqualToString:@"sex"]) {
         controller.text=self.sexLabel.text;
         controller.placeholder=@"请选择性别";
         controller.title=@"性别";
     }else if ([segue.identifier isEqualToString:@"birthday"]) {
         controller.text=self.birthdayLabel.text;
         controller.placeholder=@"请选择出生日期";
         controller.title=@"出生日期";
     }else if ([segue.identifier isEqualToString:@"mobilePhone"]) {
         controller.text=self.mobilePhoneLabel.text;
         controller.placeholder=@"请填写手机短号";
         controller.title=@"手机短号";
     }else if ([segue.identifier isEqualToString:@"telPhone"]) {
         controller.text=self.telPhoneLabel.text;
         controller.placeholder=@"请填写手机长号";
         controller.title=@"手机长号";
     }else if ([segue.identifier isEqualToString:@"qq"]) {
         controller.text=self.qqLabel.text;
         controller.placeholder=@"请填写QQ号";
         controller.title=@"QQ";
     }else if ([segue.identifier isEqualToString:@"weixin"]) {
         controller.text=self.wxLabel.text;
         controller.placeholder=@"请填写微信号";
         controller.title=@"微信";
     }else if ([segue.identifier isEqualToString:@"section"]) {
         controller.text=self.sectionLabel.text;
         controller.placeholder=@"请选择所在科室";
         controller.title=@"科室";
     }else if ([segue.identifier isEqualToString:@"sectionTel"]) {
         controller.text=self.sectionTelLabel.text;
         controller.placeholder=@"请填写所在科室电话";
         controller.title=@"科室电话";
     }else if ([segue.identifier isEqualToString:@"userJob"]) {
         controller.text=self.userJobLbel.text;
         controller.placeholder=@"请填写担任职务";
         controller.title=@"担任职务";
     }
 }

@end
