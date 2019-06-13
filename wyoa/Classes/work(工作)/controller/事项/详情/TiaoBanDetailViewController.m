//
//  TiaoBanDetailViewController.m
//  wyoa
//
//  Created by apple on 2018/8/28.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "TiaoBanDetailViewController.h"
#import "MBProgressHUD+MBProgressHUD.h"
#import "TiaoBanXiangQingBean.h"
#import "MJExtension.h"
#import "Extern.h"
#import  "UIImageView+WebCache.h"
#import "JXTAlertManagerHeader.h"
@interface TiaoBanDetailViewController ()

@end

@implementation TiaoBanDetailViewController

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
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"oaCustom/getInfoTransfer.do",apikey];
    NSDictionary *params=@{@"id":self.id,
                           @"userId":userId
                           };
    [TiaoBanXiangQingBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
        [MBProgressHUD hideHUD];
        TiaoBanXiangQingBean *tiaobanxiangqingBean=[TiaoBanXiangQingBean mj_objectWithKeyValues:dict];
        if(tiaobanxiangqingBean.success==1){
            //---------------------------------基本信息-----------------------------------------------
            if([tiaobanxiangqingBean.taTransfer.nowSex isEqualToString:@"女"]){
                [self.FaQiRenHeadImageView   sd_setImageWithURL:tiaobanxiangqingBean.taTransfer.nowPhoto placeholderImage:[UIImage   imageNamed:@"woman"]];
            }else{
                [self.FaQiRenHeadImageView   sd_setImageWithURL:tiaobanxiangqingBean.taTransfer.nowPhoto placeholderImage:[UIImage   imageNamed:@"man"]];
            }
            
            [self.FaQiRenNameLabel setText:tiaobanxiangqingBean.taTransfer.userName];
            if([tiaobanxiangqingBean.taTransfer.state isEqualToString:@"0"]){
                 [self.stateLabel setText:@"未审批"];
            }else if([tiaobanxiangqingBean.taTransfer.state isEqualToString:@"1"]){
                [self.stateLabel setText:@"审批中"];
            }else if([tiaobanxiangqingBean.taTransfer.state isEqualToString:@"2"]){
                [self.stateLabel setText:@"审批通过"];
            }else if([tiaobanxiangqingBean.taTransfer.state isEqualToString:@"3"]){
                [self.stateLabel setText:@"审批已拒绝"];
            }
       if(tiaobanxiangqingBean.taTransfer.transferSection&&tiaobanxiangqingBean.taTransfer.transferSection.length>0){
                [self.sectionLabel setText:tiaobanxiangqingBean.taTransfer.transferSection];
           }else{
                [self.sectionLabel setText:@"无"];
           }
            if(tiaobanxiangqingBean.taTransfer.transferJob&&tiaobanxiangqingBean.taTransfer.transferJob.length>0){
            [self.jobLabel setText:tiaobanxiangqingBean.taTransfer.transferJob];
            }else{
                 [self.jobLabel setText:@"无"];
            }
            if(tiaobanxiangqingBean.taTransfer.oldWorkDate&&tiaobanxiangqingBean.taTransfer.oldWorkDate.length>0){
            [self.startDateLabel setText:tiaobanxiangqingBean.taTransfer.oldWorkDate];
            }else{
                [self.startDateLabel setText:@"无"];
            }
             if(tiaobanxiangqingBean.taTransfer.nowWorkDate&&tiaobanxiangqingBean.taTransfer.nowWorkDate.length>0){
            [self.endDateLabel setText:tiaobanxiangqingBean.taTransfer.nowWorkDate];
             }else{
                  [self.endDateLabel setText:@"无"];
             }
            if(tiaobanxiangqingBean.taTransfer.transferName&&tiaobanxiangqingBean.taTransfer.transferName.length>0){
            [self.howLongLabel setText:tiaobanxiangqingBean.taTransfer.transferName];
            }else{
                 [self.howLongLabel setText:@"无"];
            }
        if(tiaobanxiangqingBean.taTransfer.incident&&tiaobanxiangqingBean.taTransfer.incident.length>0){
                 [self.reasonLabel setText:tiaobanxiangqingBean.taTransfer.incident];
            }else{
                 [self.reasonLabel setText:@"无"];
            }
            if([tiaobanxiangqingBean.taTransfer.state containsString:@"3"]){
                self.refuseLeftLabel.hidden=NO;
                self.refuseRightLabel.hidden=NO;
                if(tiaobanxiangqingBean.taTransfer.refusefor.length>0){
                    [self.refuseRightLabel setText:tiaobanxiangqingBean.taTransfer.refusefor];
                }else{
                    [self.refuseRightLabel setText:@"无"];
                }
            }else{
                self.refuseLeftLabel.hidden=YES;
                self.refuseRightLabel.hidden=YES;
            }
            //----------------------------审批人-------------------------------------------------
            if(tiaobanxiangqingBean.taTransfer.oneLevelN&&tiaobanxiangqingBean.taTransfer.oneLevelN.length>0){
                self.shenpiView1.hidden=NO;
                if([tiaobanxiangqingBean.taTransfer.oneLeveSex isEqualToString:@"女"]){
                    [self.shenpiImageView1   sd_setImageWithURL:tiaobanxiangqingBean.taTransfer.oneLevelP placeholderImage:[UIImage   imageNamed:@"woman"]];
                }else{
                    [self.shenpiImageView1   sd_setImageWithURL:tiaobanxiangqingBean.taTransfer.oneLevelP placeholderImage:[UIImage   imageNamed:@"man"]];
                }
                [self.shenpiNameLabel1 setText:tiaobanxiangqingBean.taTransfer.oneLevelN];
            }else{
                self.shenpiView1.hidden=YES;
            }
            if(tiaobanxiangqingBean.taTransfer.twoLevelN&&tiaobanxiangqingBean.taTransfer.twoLevelN.length>0){
                self.shenpiView2.hidden=NO;
                self.nextImageView1.hidden=NO;
                if([tiaobanxiangqingBean.taTransfer.twoLeveSex isEqualToString:@"女"]){
                    [self.shenpiImageView2   sd_setImageWithURL:tiaobanxiangqingBean.taTransfer.twoLevelP placeholderImage:[UIImage   imageNamed:@"woman"]];
                }else{
                    [self.shenpiImageView2   sd_setImageWithURL:tiaobanxiangqingBean.taTransfer.twoLevelP placeholderImage:[UIImage   imageNamed:@"man"]];
                }
                [self.shenpiNamelabel2 setText:tiaobanxiangqingBean.taTransfer.twoLevelN];
            }else{
                self.shenpiView2.hidden=YES;
                self.nextImageView1.hidden=YES;
            }
            if(tiaobanxiangqingBean.taTransfer.threeLevelN&&tiaobanxiangqingBean.taTransfer.threeLevelN.length>0){
                self.shenpiView3.hidden=NO;
                self.nextImageView2.hidden=NO;
                if([tiaobanxiangqingBean.taTransfer.threeLeveSex isEqualToString:@"女"]){
                    [self.shenpiImageView3   sd_setImageWithURL:tiaobanxiangqingBean.taTransfer.threeLevelP placeholderImage:[UIImage   imageNamed:@"woman"]];
                }else{
                    [self.shenpiImageView3   sd_setImageWithURL:tiaobanxiangqingBean.taTransfer.threeLevelP placeholderImage:[UIImage   imageNamed:@"man"]];
                }
                [self.shenpiNamelabel3 setText:tiaobanxiangqingBean.taTransfer.threeLevelN];
            }else{
                self.shenpiView3.hidden=YES;
                self.nextImageView2.hidden=YES;
            }
            //------------------------------抄送人------------------------------------------
            if([tiaobanxiangqingBean.taTransfer.chaoSongSex isEqualToString:@"女"]){
                [self.chaoSongImageView   sd_setImageWithURL:tiaobanxiangqingBean.taTransfer.chaoSongPic placeholderImage:[UIImage   imageNamed:@"woman"]];
            }else{
                [self.chaoSongImageView   sd_setImageWithURL:tiaobanxiangqingBean.taTransfer.chaoSongPic placeholderImage:[UIImage   imageNamed:@"man"]];
            }
            [self.chaoSongLabel setText:tiaobanxiangqingBean.taTransfer.chaoSongName];
        }else{
            [MBProgressHUD showError:tiaobanxiangqingBean.message];
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
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"oaCustom/updateTransferA.do",apikey];
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
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"oaCustom/updateTransferN.do",apikey];
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
