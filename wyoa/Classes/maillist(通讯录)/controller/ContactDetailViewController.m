//
//  ContactDetailViewController.m
//  wyoa
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "ContactDetailViewController.h"
#import  "UIImageView+WebCache.h"
#import <MessageUI/MessageUI.h>
#import "MBProgressHUD+MBProgressHUD.h"
@interface ContactDetailViewController ()<MFMessageComposeViewControllerDelegate>

@end

@implementation ContactDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if([self.userInfoBean.sex isEqualToString:@"女"]){
        [self.headImageView   sd_setImageWithURL:self.userInfoBean.headPhoto placeholderImage:[UIImage   imageNamed:@"woman"]];
    }else{
        [self.headImageView   sd_setImageWithURL:self.userInfoBean.headPhoto placeholderImage:[UIImage   imageNamed:@"man"]];
    }
    [self.realNameLabel setText:self.userInfoBean.name];
    [self.telphoneLabel setText:self.userInfoBean.telphone];
    [self.mobilePhoneLabel setText:self.userInfoBean.mobilePhone];
    [self.userJobLabel setText:self.userInfoBean.job];
    [self.sectionLabel setText:self.userInfoBean.secition];
    [self.sectionPhoneLabel setText:self.userInfoBean.sectionPhone];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)messageClick:(id)sender {
    if(self.telphoneLabel.text.length>0){
        MFMessageComposeViewController *vc = [[MFMessageComposeViewController alloc] init];
        // 设置收件人列表
        vc.recipients = @[_telphoneLabel.text];  // 号码数组
        // 设置代理
        vc.messageComposeDelegate = self;
        // 显示控制器
        [self presentViewController:vc animated:YES completion:nil];
    }else{
        [MBProgressHUD showError:@"暂无手机长号"];
    }
   
}

- (IBAction)telphoneClick:(id)sender {
    if(self.telphoneLabel.text.length>0){
        [self callPhone:self.telphoneLabel.text];
    }else{
        [MBProgressHUD showError:@"暂无手机长号"];
    }
}
- (IBAction)mobilePhoneClick:(id)sender {
    if(self.mobilePhoneLabel.text.length>0){
         [self callPhone:self.mobilePhoneLabel.text];
    }else{
        [MBProgressHUD showError:@"暂无手机短号"];
    }
    
}

- (IBAction)sectionPhoneClick:(id)sender {
    if(self.sectionPhoneLabel.text.length>0){
        [self callPhone:self.sectionPhoneLabel.text];
    }else{
        [MBProgressHUD showError:@"暂无科室电话"];
    }
    
}

-(void)callPhone:(NSString *)telephoneNumber{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",telephoneNumber];
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:str];
    if (@available(iOS 10.0, *)) {
        [application openURL:URL options:@{} completionHandler:^(BOOL success) {
            //OpenSuccess=选择 呼叫 为 1  选择 取消 为0
            NSLog(@"OpenSuccess=%d",success);
            
        }];
    } else {
            UIWebView *webView = [[UIWebView alloc] init];
            NSString *string = [NSString stringWithFormat:@"tel://%@",telephoneNumber];
            NSURL *url = [NSURL URLWithString:string];
        
            [webView loadRequest:[NSURLRequest requestWithURL:url]];
        
            [self.view addSubview:webView];
    }
   
    

  
}

- (void)messageComposeViewController:(MFMessageComposeViewController*)controller didFinishWithResult:(MessageComposeResult)result
{
    // 关闭短信界面
    [controller dismissViewControllerAnimated:YES completion:nil];
    if(result == MessageComposeResultCancelled) {
        NSLog(@"取消发送");
    } else if(result == MessageComposeResultSent) {
        NSLog(@"已经发出");
    } else {
        NSLog(@"发送失败");
    }
}

@end
