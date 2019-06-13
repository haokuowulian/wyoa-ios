//
//  GongChaiDetailViewController.m
//  wyoa
//
//  Created by apple on 2018/8/28.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "GongChaiDetailViewController.h"
#import "MBProgressHUD+MBProgressHUD.h"
#import "GongChaiXiangQingBean.h"
#import "MJExtension.h"
#import "Extern.h"
#import  "UIImageView+WebCache.h"
#import "JXTAlertManagerHeader.h"
@interface GongChaiDetailViewController ()

@end

@implementation GongChaiDetailViewController

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
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"oaOffice/getInfoTrip.do",apikey];
    NSDictionary *params=@{@"id":self.id,
                           @"userId":userId
                           };
    [GongChaiXiangQingBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
        [MBProgressHUD hideHUD];
        GongChaiXiangQingBean *gongchaixiangqingBean=[GongChaiXiangQingBean mj_objectWithKeyValues:dict];
        if(gongchaixiangqingBean.success==1){
     //---------------------------------基本信息-----------------------------------------------
            if([gongchaixiangqingBean.trip.user.sex isEqualToString:@"女"]){
                [self.FaQiRenHeadImageView   sd_setImageWithURL:gongchaixiangqingBean.trip.userInfo.headPhoto placeholderImage:[UIImage   imageNamed:@"woman"]];
            }else{
                [self.FaQiRenHeadImageView   sd_setImageWithURL:gongchaixiangqingBean.trip.userInfo.headPhoto placeholderImage:[UIImage   imageNamed:@"man"]];
            }
            
            [self.FaQiRenNameLabel setText:gongchaixiangqingBean.trip.userInfo.realName];
            [self.stateLabel setText:gongchaixiangqingBean.trip.appState];
            [self.sectionLabel setText:gongchaixiangqingBean.trip.userInfo.secition];
            [self.jobLabel setText:gongchaixiangqingBean.trip.userInfo.job];
            [self.startDateLabel setText:gongchaixiangqingBean.trip.startDate];
            [self.endDateLabel setText:gongchaixiangqingBean.trip.endDate];
            [self.howLongLabel setText:gongchaixiangqingBean.trip.howlong];
            [self.reasonLabel setText:gongchaixiangqingBean.trip.incident];
            if([gongchaixiangqingBean.trip.appStatus containsString:@"拒绝"]){
                self.refuseLeftLabel.hidden=NO;
                self.refuseRightLabel.hidden=NO;
                if(gongchaixiangqingBean.trip.refusefor.length>0){
                    [self.refuseRightLabel setText:gongchaixiangqingBean.trip.refusefor];
                }else{
                    [self.refuseRightLabel setText:@"无"];
                }
            }else{
                self.refuseLeftLabel.hidden=YES;
                self.refuseRightLabel.hidden=YES;
            }
            //----------------------------审批人-------------------------------------------------
            if(gongchaixiangqingBean.trip.oneLevelN&&gongchaixiangqingBean.trip.oneLevelN.length>0){
                self.shenpiView1.hidden=NO;
                if([gongchaixiangqingBean.trip.oneLeveSex isEqualToString:@"女"]){
                    [self.shenpiImageView1   sd_setImageWithURL:gongchaixiangqingBean.trip.oneLevelP placeholderImage:[UIImage   imageNamed:@"woman"]];
                }else{
                    [self.shenpiImageView1   sd_setImageWithURL:gongchaixiangqingBean.trip.oneLevelP placeholderImage:[UIImage   imageNamed:@"man"]];
                }
                [self.shenpiNameLabel1 setText:gongchaixiangqingBean.trip.oneLevelN];
            }else{
                self.shenpiView1.hidden=YES;
            }
            if(gongchaixiangqingBean.trip.twoLevelN&&gongchaixiangqingBean.trip.twoLevelN.length>0){
                self.shenpiView2.hidden=NO;
                self.nextImageView1.hidden=NO;
                if([gongchaixiangqingBean.trip.twoLeveSex isEqualToString:@"女"]){
                    [self.shenpiImageView2   sd_setImageWithURL:gongchaixiangqingBean.trip.twoLevelP placeholderImage:[UIImage   imageNamed:@"woman"]];
                }else{
                    [self.shenpiImageView2   sd_setImageWithURL:gongchaixiangqingBean.trip.twoLevelP placeholderImage:[UIImage   imageNamed:@"man"]];
                }
                [self.shenpiNamelabel2 setText:gongchaixiangqingBean.trip.twoLevelN];
            }else{
                self.shenpiView2.hidden=YES;
                self.nextImageView1.hidden=YES;
            }
            if(gongchaixiangqingBean.trip.threeLevelN&&gongchaixiangqingBean.trip.threeLevelN.length>0){
                self.shenpiView3.hidden=NO;
                self.nextImageView2.hidden=NO;
                if([gongchaixiangqingBean.trip.threeLeveSex isEqualToString:@"女"]){
                    [self.shenpiImageView3   sd_setImageWithURL:gongchaixiangqingBean.trip.threeLevelP placeholderImage:[UIImage   imageNamed:@"woman"]];
                }else{
                    [self.shenpiImageView3   sd_setImageWithURL:gongchaixiangqingBean.trip.threeLevelP placeholderImage:[UIImage   imageNamed:@"man"]];
                }
                [self.shenpiNamelabel3 setText:gongchaixiangqingBean.trip.threeLevelN];
            }else{
                self.shenpiView3.hidden=YES;
                self.nextImageView2.hidden=YES;
            }
            //------------------------------抄送人------------------------------------------
            if([gongchaixiangqingBean.trip.chaoSongSex isEqualToString:@"女"]){
                [self.chaoSongImageView   sd_setImageWithURL:gongchaixiangqingBean.trip.chaoSongPic placeholderImage:[UIImage   imageNamed:@"woman"]];
            }else{
                [self.chaoSongImageView   sd_setImageWithURL:gongchaixiangqingBean.trip.chaoSongPic placeholderImage:[UIImage   imageNamed:@"man"]];
            }
            [self.chaoSongLabel setText:gongchaixiangqingBean.trip.chaoSongName];
        }else{
            [MBProgressHUD showError:gongchaixiangqingBean.message];
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
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"oaOffice/toDealtWithTrip.do",apikey];
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
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"oaOffice/toDealtRefusedTrip.do",apikey];
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
