//
//  LingYongDetailViewController.m
//  wyoa
//
//  Created by apple on 2018/8/28.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "LingYongDetailViewController.h"
#import "MBProgressHUD+MBProgressHUD.h"
#import "LingYongXiangQingBean.h"
#import "MJExtension.h"
#import "Extern.h"
#import  "UIImageView+WebCache.h"
#import "JXTAlertManagerHeader.h"
@interface LingYongDetailViewController ()

@end

@implementation LingYongDetailViewController

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
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"oaOffice/getInfoItemsapply.do",apikey];
    NSDictionary *params=@{@"id":self.id,
                           @"userId":userId
                           };
    [LingYongXiangQingBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
        [MBProgressHUD hideHUD];
        LingYongXiangQingBean *lingyongxiangqingBean=[LingYongXiangQingBean mj_objectWithKeyValues:dict];
        if(lingyongxiangqingBean.success==1){
            //---------------------------------基本信息-----------------------------------------------
            if([lingyongxiangqingBean.itemsapply.nowSex isEqualToString:@"女"]){
                [self.FaQiRenHeadImageView   sd_setImageWithURL:lingyongxiangqingBean.itemsapply.nowPhoto placeholderImage:[UIImage   imageNamed:@"woman"]];
            }else{
                [self.FaQiRenHeadImageView   sd_setImageWithURL:lingyongxiangqingBean.itemsapply.nowPhoto placeholderImage:[UIImage   imageNamed:@"man"]];
            }
            
            [self.FaQiRenNameLabel setText:lingyongxiangqingBean.itemsapply.userInfo.realName];
            [self.stateLabel setText:lingyongxiangqingBean.itemsapply.appState];
            [self.sectionLabel setText:lingyongxiangqingBean.itemsapply.userInfo.secition];
            [self.jobLabel setText:lingyongxiangqingBean.itemsapply.userInfo.job];
            
            [self.wupinNameLabel setText:lingyongxiangqingBean.itemsapply.items_name];
           
            [self.reasonLabel setText:lingyongxiangqingBean.itemsapply.incident];
            if([lingyongxiangqingBean.itemsapply.appState containsString:@"拒绝"]){
                self.refuseLeftLabel.hidden=NO;
                self.refuseRightLabel.hidden=NO;
                if(lingyongxiangqingBean.itemsapply.refusefor.length>0){
                    [self.refuseRightLabel setText:lingyongxiangqingBean.itemsapply.refusefor];
                }else{
                    [self.refuseRightLabel setText:@"无"];
                }
            }else{
                self.refuseLeftLabel.hidden=YES;
                self.refuseRightLabel.hidden=YES;
            }
            //----------------------------审批人-------------------------------------------------
            if(lingyongxiangqingBean.itemsapply.oneLevelN&&lingyongxiangqingBean.itemsapply.oneLevelN.length>0){
                self.shenpiView1.hidden=NO;
                if([lingyongxiangqingBean.itemsapply.oneLeveSex isEqualToString:@"女"]){
                    [self.shenpiImageView1   sd_setImageWithURL:lingyongxiangqingBean.itemsapply.oneLevelP placeholderImage:[UIImage   imageNamed:@"woman"]];
                }else{
                    [self.shenpiImageView1   sd_setImageWithURL:lingyongxiangqingBean.itemsapply.oneLevelP placeholderImage:[UIImage   imageNamed:@"man"]];
                }
                [self.shenpiNameLabel1 setText:lingyongxiangqingBean.itemsapply.oneLevelN];
            }else{
                self.shenpiView1.hidden=YES;
            }
            if(lingyongxiangqingBean.itemsapply.twoLevelN&&lingyongxiangqingBean.itemsapply.twoLevelN.length>0){
                self.shenpiView2.hidden=NO;
                self.nextImageView1.hidden=NO;
                if([lingyongxiangqingBean.itemsapply.twoLeveSex isEqualToString:@"女"]){
                    [self.shenpiImageView2   sd_setImageWithURL:lingyongxiangqingBean.itemsapply.twoLevelP placeholderImage:[UIImage   imageNamed:@"woman"]];
                }else{
                    [self.shenpiImageView2   sd_setImageWithURL:lingyongxiangqingBean.itemsapply.twoLevelP placeholderImage:[UIImage   imageNamed:@"man"]];
                }
                [self.shenpiNamelabel2 setText:lingyongxiangqingBean.itemsapply.twoLevelN];
            }else{
                self.shenpiView2.hidden=YES;
                self.nextImageView1.hidden=YES;
            }
            if(lingyongxiangqingBean.itemsapply.threeLevelN&&lingyongxiangqingBean.itemsapply.threeLevelN.length>0){
                self.shenpiView3.hidden=NO;
                self.nextImageView2.hidden=NO;
                if([lingyongxiangqingBean.itemsapply.threeLeveSex isEqualToString:@"女"]){
                    [self.shenpiImageView3   sd_setImageWithURL:lingyongxiangqingBean.itemsapply.threeLevelP placeholderImage:[UIImage   imageNamed:@"woman"]];
                }else{
                    [self.shenpiImageView3   sd_setImageWithURL:lingyongxiangqingBean.itemsapply.threeLevelP placeholderImage:[UIImage   imageNamed:@"man"]];
                }
                [self.shenpiNamelabel3 setText:lingyongxiangqingBean.itemsapply.threeLevelN];
            }else{
                self.shenpiView3.hidden=YES;
                self.nextImageView2.hidden=YES;
            }
            //------------------------------抄送人------------------------------------------
            if([lingyongxiangqingBean.itemsapply.chaoSongSex isEqualToString:@"女"]){
                [self.chaoSongImageView   sd_setImageWithURL:lingyongxiangqingBean.itemsapply.chaoSongPic placeholderImage:[UIImage   imageNamed:@"woman"]];
            }else{
                [self.chaoSongImageView   sd_setImageWithURL:lingyongxiangqingBean.itemsapply.chaoSongPic placeholderImage:[UIImage   imageNamed:@"man"]];
            }
            [self.chaoSongLabel setText:lingyongxiangqingBean.itemsapply.chaoSongName];
        }else{
            [MBProgressHUD showError:lingyongxiangqingBean.message];
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
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"oaOffice/updateItemsApply.do",apikey];
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
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"oaOffice/refuseItemsApply.do",apikey];
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
