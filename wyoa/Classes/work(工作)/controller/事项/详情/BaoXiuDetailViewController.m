//
//  BaoXiuDetailViewController.m
//  wyoa
//
//  Created by apple on 2018/8/28.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "BaoXiuDetailViewController.h"
#import "MBProgressHUD+MBProgressHUD.h"
#import "BaoXiuXiangQingBean.h"
#import "MJExtension.h"
#import "Extern.h"
#import  "UIImageView+WebCache.h"
#import "JXTAlertManagerHeader.h"

@interface BaoXiuDetailViewController ()

@end

@implementation BaoXiuDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [MBProgressHUD showMessage:@"正在获取详情信息..."];
    if(self.needDeal){
        self.bottomView.hidden=NO;
    }else{
        self.bottomView.hidden=YES;
    }
    [self getDetail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark 获取详情
-(void)getDetail{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *userId=[userDefault objectForKey:@"userId"];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"oaOffice/getInfofix.do",apikey];
    NSDictionary *params=@{@"id":self.id,
                           @"userId":userId
                           };
    [BaoXiuXiangQingBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
        [MBProgressHUD hideHUD];
        BaoXiuXiangQingBean *baoxiuxiangqingBean=[BaoXiuXiangQingBean mj_objectWithKeyValues:dict];
        if(baoxiuxiangqingBean.success==1){
            //---------------------------------基本信息-----------------------------------------------
            if([baoxiuxiangqingBean.fixList.nowSex isEqualToString:@"女"]){
                [self.FaQiRenHeadImageView   sd_setImageWithURL:baoxiuxiangqingBean.fixList.nowPhoto placeholderImage:[UIImage   imageNamed:@"woman"]];
            }else{
                [self.FaQiRenHeadImageView   sd_setImageWithURL:baoxiuxiangqingBean.fixList.nowPhoto placeholderImage:[UIImage   imageNamed:@"man"]];
            }
            
            [self.FaQiRenNameLabel setText:baoxiuxiangqingBean.fixList.realname];
            [self.stateLabel setText:baoxiuxiangqingBean.fixList.appStatus];
            [self.sectionLabel setText:baoxiuxiangqingBean.fixList.section];
            [self.jobLabel setText:baoxiuxiangqingBean.fixList.job];
            
            [self.wupinNameLabel setText:baoxiuxiangqingBean.fixList.fixItems];
            [self.addressLabel setText:baoxiuxiangqingBean.fixList.fixAddress];
            [self.exceptDateLabel setText:baoxiuxiangqingBean.fixList.expectfixDate];
            [self.reasonLabel setText:baoxiuxiangqingBean.fixList.damage];
            if([baoxiuxiangqingBean.fixList.appStatus containsString:@"拒绝"]){
                self.refuseLeftLabel.hidden=NO;
                self.refuseRightLabel.hidden=NO;
                if(baoxiuxiangqingBean.fixList.refusefor.length>0){
                    [self.refuseRightLabel setText:baoxiuxiangqingBean.fixList.refusefor];
                }else{
                    [self.refuseRightLabel setText:@"无"];
                }
            }else{
                self.refuseLeftLabel.hidden=YES;
                self.refuseRightLabel.hidden=YES;
            }
            //----------------------------审批人-------------------------------------------------
            if(baoxiuxiangqingBean.fixList.oneLevelN&&baoxiuxiangqingBean.fixList.oneLevelN.length>0){
                self.shenpiView1.hidden=NO;
                if([baoxiuxiangqingBean.fixList.oneLeveSex isEqualToString:@"女"]){
                    [self.shenpiImageView1   sd_setImageWithURL:baoxiuxiangqingBean.fixList.oneLevelP placeholderImage:[UIImage   imageNamed:@"woman"]];
                }else{
                    [self.shenpiImageView1   sd_setImageWithURL:baoxiuxiangqingBean.fixList.oneLevelP placeholderImage:[UIImage   imageNamed:@"man"]];
                }
                [self.shenpiNameLabel1 setText:baoxiuxiangqingBean.fixList.oneLevelN];
            }else{
                self.shenpiView1.hidden=YES;
            }
            if(baoxiuxiangqingBean.fixList.twoLevelN&&baoxiuxiangqingBean.fixList.twoLevelN.length>0){
                self.shenpiView2.hidden=NO;
                self.nextImageView1.hidden=NO;
                if([baoxiuxiangqingBean.fixList.twoLeveSex isEqualToString:@"女"]){
                    [self.shenpiImageView2   sd_setImageWithURL:baoxiuxiangqingBean.fixList.twoLevelP placeholderImage:[UIImage   imageNamed:@"woman"]];
                }else{
                    [self.shenpiImageView2   sd_setImageWithURL:baoxiuxiangqingBean.fixList.twoLevelP placeholderImage:[UIImage   imageNamed:@"man"]];
                }
                [self.shenpiNamelabel2 setText:baoxiuxiangqingBean.fixList.twoLevelN];
            }else{
                self.shenpiView2.hidden=YES;
                self.nextImageView1.hidden=YES;
            }
            if(baoxiuxiangqingBean.fixList.threeLevelN&&baoxiuxiangqingBean.fixList.threeLevelN.length>0){
                self.shenpiView3.hidden=NO;
                self.nextImageView2.hidden=NO;
                if([baoxiuxiangqingBean.fixList.threeLeveSex isEqualToString:@"女"]){
                    [self.shenpiImageView3   sd_setImageWithURL:baoxiuxiangqingBean.fixList.threeLevelP placeholderImage:[UIImage   imageNamed:@"woman"]];
                }else{
                    [self.shenpiImageView3   sd_setImageWithURL:baoxiuxiangqingBean.fixList.threeLevelP placeholderImage:[UIImage   imageNamed:@"man"]];
                }
                [self.shenpiNamelabel3 setText:baoxiuxiangqingBean.fixList.threeLevelN];
            }else{
                self.shenpiView3.hidden=YES;
                self.nextImageView2.hidden=YES;
            }
            //------------------------------抄送人------------------------------------------
            if([baoxiuxiangqingBean.fixList.chaoSongSex isEqualToString:@"女"]){
                [self.chaoSongImageView   sd_setImageWithURL:baoxiuxiangqingBean.fixList.chaoSongPic placeholderImage:[UIImage   imageNamed:@"woman"]];
            }else{
                [self.chaoSongImageView   sd_setImageWithURL:baoxiuxiangqingBean.fixList.chaoSongPic placeholderImage:[UIImage   imageNamed:@"man"]];
            }
            [self.chaoSongLabel setText:baoxiuxiangqingBean.fixList.chaoSongName];
        }else{
            [MBProgressHUD showError:baoxiuxiangqingBean.message];
        }
    } Error:^(NSError *err) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"网络连接失败"];
    }];
}
- (IBAction)refuseClick:(id)sender {
    [self jxt_showAlertWithTitle:@"提示" message:@"确定拒绝该审批吗？若拒绝请填写拒绝理由" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
        alertMaker.
        addActionCancelTitle(@"取消").
        addActionDestructiveTitle(@"确定");
        
        [alertMaker addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请填写拒绝理由";
        }];
        
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
        if (buttonIndex == 1) {
            UITextField *textField = alertSelf.textFields.lastObject;
            [self refuse:textField.text];
        }
    }];
}

- (IBAction)agreenClick:(id)sender {
    [self jxt_showAlertWithTitle:@"提示" message:@"确定同意该审批吗？" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
        alertMaker.
        addActionCancelTitle(@"取消").
        addActionDestructiveTitle(@"确定");
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
        if (buttonIndex == 1) {
            [self agree];
        }
    }];
}

#pragma mark 同意
-(void)agree{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *userId=[userDefault objectForKey:@"userId"];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"oaOffice/agreeFixState.do",apikey];
    NSDictionary *params=@{@"id":self.id,
                           @"userId":userId
                           };
    [BaseBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
        BaseBean *baseBean=[BaseBean mj_objectWithKeyValues:dict];
        if(baseBean.success==1){
            [self.navigationController popViewControllerAnimated:YES];
            //创建一个消息对象
            NSNotification * notice = [NSNotification notificationWithName:@"shixiangRefresh" object:nil];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
            //创建一个消息对象
            NSNotification * notice2 = [NSNotification notificationWithName:@"numRefresh" object:nil];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice2];
        }else{
            [MBProgressHUD showError:baseBean.message];
        }
    } Error:^(NSError *err) {
        [MBProgressHUD showError:@"网络连接失败"];
    }];
}


#pragma mark 拒绝
-(void)refuse:(NSString *)reason{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *userId=[userDefault objectForKey:@"userId"];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"oaOffice/infixReusefor.do",apikey];
    if(reason.length==0){
        reason=@"无";
    }
    NSDictionary *params=@{@"id":self.id,
                           @"userId":userId,
                           @"refusefor":reason
                           };
    [BaseBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
        BaseBean *baseBean=[BaseBean mj_objectWithKeyValues:dict];
        if(baseBean.success==1){
            [self.navigationController popViewControllerAnimated:YES];
            //创建一个消息对象
            NSNotification * notice = [NSNotification notificationWithName:@"shixiangRefresh" object:nil];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
            //创建一个消息对象
            NSNotification * notice2 = [NSNotification notificationWithName:@"numRefresh" object:nil];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice2];
        }else{
            [MBProgressHUD showError:baseBean.message];
        }
    } Error:^(NSError *err) {
        [MBProgressHUD showError:@"网络连接失败"];
    }];
}


@end
