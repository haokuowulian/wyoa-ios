//
//  QingJiaViewController.m
//  wyoa
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "QingJiaViewController.h"
#import "JXTAlertManagerHeader.h"
#import "WYBirthdayPickerView.h"
#import "QIngJiaShenPiRenBean.h"
#import "MJExtension.h"
#import  "UIImageView+WebCache.h"
#import "Extern.h"
#import "MailListViewController.h"
#import "ContactBean.h"
#import "BaseBean.h"
#import "TimeUtil.h"
#import "MBProgressHUD+MBProgressHUD.h"
#import "MNDatePickerView.h"
@interface QingJiaViewController ()<MNDatePickerViewDelegate>
@property(nonatomic,copy)NSString *leaveType;//请假类别
@property(nonatomic,copy)NSString *courtesyCopyId;//抄送人ID
@property(nonatomic,copy)NSString *onelevelId;//1级审批人ID;
@property(nonatomic,copy)NSString *twolevelId;//2级审批人ID;
@property(nonatomic,copy)NSString *threelevelId;//3级审批人ID;

@property(nonatomic,strong)MNDatePickerView *picker;
@end

@implementation QingJiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.courtesyCopyId=@"0";
    
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(selectUser:) name:@"selectUser" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self setVisible];
     [self getShenPiRen];
}

-(void)selectUser:(id)sender{
    ContactBean *bean=[sender object];
    if([bean.sex isEqualToString:@"女"]){
        [self.chaoSongImageView   sd_setImageWithURL:bean.headPhoto placeholderImage:[UIImage   imageNamed:@"woman"]];
    }else{
        [self.chaoSongImageView   sd_setImageWithURL:bean.headPhoto placeholderImage:[UIImage   imageNamed:@"man"]];
    }
    [self.chaoSongLabel setText:bean.name];
    self.courtesyCopyId=bean.id;
}
- (IBAction)typeClick:(id)sender {
    [self jxt_showActionSheetWithTitle:@"请选择请假类型" message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
        alertMaker.
        addActionCancelTitle(@"取消").
//        addActionDestructiveTitle(@"公假").
        addActionDestructiveTitle(@"病假").
        addActionDestructiveTitle(@"事假").
        addActionDestructiveTitle(@"其它");
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
        if ([action.title isEqualToString:@"公假"]) {
            [self.typeText setText:@"公假"];
            self.leaveType=@"0";
        }
        else if ([action.title isEqualToString:@"病假"]) {
            [self.typeText setText:@"病假"];
             self.leaveType=@"1";
        }
        else if ([action.title isEqualToString:@"事假"]) {
            [self.typeText setText:@"事假"];
             self.leaveType=@"2";
        }
        else if ([action.title isEqualToString:@"其它"]) {
            [self.typeText setText:@"其它"];
             self.leaveType=@"3";
        }
    }];
    
}
- (IBAction)startTimeClick:(id)sender {
    [self initPickerView:self.startTimeText];
    [self.picker showPickerView];
   
}
- (IBAction)endTimeClick:(id)sender {
     [self initPickerView:self.endTimeText];
     [self.picker showPickerView];
}
- (IBAction)addChaoSongRen:(id)sender {
//    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"MailList" bundle:nil];
//    MailListViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"mailList"];
//    controller.isFromSelect=YES;
//    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)submitClick:(id)sender {
    if([self checkIsEmpty]){
        [self submit];
    }else{
        [MBProgressHUD showError:@"请检查信息是否填写完整"];
    }
}


#pragma mark 时间选择
-(void)selectDateTime:(UITextField *)textField{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    dateFormatter.dateFormat=@"yyyy-MM-dd";
    WYBirthdayPickerView *datePickerView = [[WYBirthdayPickerView alloc] initWithInitialDate:[dateFormatter stringFromDate:[NSDate date]]andDateFormatter:@"yyyy-MM-dd"];
    // 选择日期完成之后的回调 : 按自己的要求做相应的处理就可以了
    datePickerView.confirmBlock = ^(NSString *selectedDate) {
       textField.text=selectedDate;
        
    };
    
    [self.view addSubview:datePickerView];
}

#pragma mark 获取审批人
-(void)getShenPiRen{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *userId=[userDefault objectForKey:@"userId"];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"oaOffice/getInApprove.do",apikey];
    NSDictionary *params=@{@"userId":userId};
    [QIngJiaShenPiRenBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
        QIngJiaShenPiRenBean *qingjiaShenPiBean=[QIngJiaShenPiRenBean mj_objectWithKeyValues:dict];
        self.onelevelId=qingjiaShenPiBean.oneLevelId;
        self.twolevelId=qingjiaShenPiBean.twoLevelId;
        self.threelevelId=qingjiaShenPiBean.threeLevelId;

        if(qingjiaShenPiBean.success==1){
            if(qingjiaShenPiBean.CourtesyCopyId&&qingjiaShenPiBean.CourtesyCopyId.length>0){
                self.courtesyCopyId=qingjiaShenPiBean.CourtesyCopyId;
                if([qingjiaShenPiBean.CourtesyCopySex isEqualToString:@"女"]){
                    [self.chaoSongImageView   sd_setImageWithURL:qingjiaShenPiBean.CourtesyCopylP placeholderImage:[UIImage   imageNamed:@"woman"]];
                }else{
                    [self.chaoSongImageView   sd_setImageWithURL:qingjiaShenPiBean.CourtesyCopylP placeholderImage:[UIImage   imageNamed:@"man"]];
                }
                [self.chaoSongLabel setText:qingjiaShenPiBean.CourtesyCopylN];
            }
            if(qingjiaShenPiBean.oneLevelId&&qingjiaShenPiBean.oneLevelId.length>0){
                self.shenpiView1.hidden=NO;
                if([qingjiaShenPiBean.oneLeveSex isEqualToString:@"女"]){
                    [self.shenpiImageView1   sd_setImageWithURL:qingjiaShenPiBean.oneLevelP placeholderImage:[UIImage   imageNamed:@"woman"]];
                }else{
                    [self.shenpiImageView1   sd_setImageWithURL:qingjiaShenPiBean.oneLevelP placeholderImage:[UIImage   imageNamed:@"man"]];
                }
                
                [self.shenpiNameLabel1 setText:qingjiaShenPiBean.oneLevelN];
            }else{
                self.shenpiView1.hidden=YES;
            }
            if(qingjiaShenPiBean.twoLevelId&&qingjiaShenPiBean.twoLevelId.length>0){
                self.shenpiView2.hidden=NO;
                self.nextImageView1.hidden=NO;
                if([qingjiaShenPiBean.twoLeveSex isEqualToString:@"女"]){
                    [self.shenpiImageView2   sd_setImageWithURL:qingjiaShenPiBean.twoLevelP placeholderImage:[UIImage   imageNamed:@"woman"]];
                }else{
                    [self.shenpiImageView2   sd_setImageWithURL:qingjiaShenPiBean.twoLevelP placeholderImage:[UIImage   imageNamed:@"man"]];
                }
                
                [self.shenpiNamelabel2 setText:qingjiaShenPiBean.twoLevelN];
            }else{
                self.shenpiView2.hidden=YES;
                self.nextImageView1.hidden=YES;
            }
            if(qingjiaShenPiBean.threeLevelId&&qingjiaShenPiBean.threeLevelId.length>0){
                self.shenpiView3.hidden=NO;
                self.nextImageView2.hidden=NO;
                if([qingjiaShenPiBean.threeLeveSex isEqualToString:@"女"]){
                    [self.shenpiImageView3   sd_setImageWithURL:qingjiaShenPiBean.threeLevelP placeholderImage:[UIImage   imageNamed:@"woman"]];
                }else{
                    [self.shenpiImageView3   sd_setImageWithURL:qingjiaShenPiBean.threeLevelP placeholderImage:[UIImage   imageNamed:@"man"]];
                }
                
                [self.shenpiNamelabel3 setText:qingjiaShenPiBean.threeLevelN];
            }else{
                self.shenpiView3.hidden=YES;
                self.nextImageView2.hidden=YES;
            }
        }
        
    } Error:^(NSError *err) {
        
    }];
}
#pragma mark 设置审批人是否可见
-(void)setVisible{
    self.shenpiView1.hidden=YES;
    self.nextImageView1.hidden=YES;
    self.shenpiView2.hidden=YES;
    self.nextImageView2.hidden=YES;
    self.shenpiView3.hidden=YES;
}
#pragma mark 验证信息是否填写完整
-(BOOL)checkIsEmpty{
    if(self.typeText.text.length>0&&
       self.startTimeText.text.length>0&&
       self.endTimeText.text.length>0&&
       self.howLongText.text.length>0&&
       self.reasonText.text.length>0){
        return YES;
    }else{
        return NO;
    }
}
#pragma mark 提交请假
-(void)submit{
    [MBProgressHUD showMessage:@"正在提交..."];
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *userId=[userDefault objectForKey:@"userId"];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"oaOffice/launchApproce.do",apikey];
    
    NSDictionary *temp=@{@"userId":userId,
                           @"leaveType":self.leaveType,
                           @"fillformDate":[TimeUtil getCurrentTimesNOHour],
                           @"incident":self.reasonText.text,
                           @"startDate":self.startTimeText.text,
                           @"endDate":self.endTimeText.text,
                           @"howlong":self.howLongText.text,
                           @"courtesyCopyId":self.courtesyCopyId
                           };
    NSMutableDictionary *params=[temp mutableCopy];
    if(self.onelevelId){
        
        [params setValue:self.onelevelId forKey:@"onelevelId"];
    }
    if(self.twolevelId){
        [params setValue:self.twolevelId forKey:@"twolevelId"];
    }
    if(self.threelevelId){
        [params setValue:self.threelevelId forKey:@"threelevelId"];
    }
    [BaseBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
        BaseBean *basebean=[BaseBean mj_objectWithKeyValues:dict];
        [MBProgressHUD hideHUD];
        if(basebean.success==1){
            [MBProgressHUD showSuccess:@"提交成功，请等待审批"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:basebean.message];
        }
    } Error:^(NSError *err) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"网络连接失败"];
    }];
    
}

#pragma mark 选择时间
-(void)initPickerView:(UITextField *)textField{
    NSDate *nowDate = [NSDate new];
    _picker = [[MNDatePickerView alloc] initWithDate:nowDate withDatePickerMode:UIDatePickerModeDateAndTime];
    _picker.delegate = self;
    if(textField==self.startTimeText){
         _picker.pickerTag = 1;
    }else if(textField==self.endTimeText){
        _picker.pickerTag = 2;
    }
   
}

-(void)MNDatePickerViewSelectedDate:(NSDate *)date tag:(NSInteger)tag
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     dateFormatter.dateFormat = @"yyyy-MM-dd hh:mm";
      NSString *dateStr01 = [dateFormatter stringFromDate:date];
    if(tag == 1){
        self.startTimeText.text = dateStr01;
    }else if(tag==2){
         self.endTimeText.text = dateStr01;
    }
}
@end
