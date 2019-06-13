//
//  TiaoBanViewController.m
//  wyoa
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "TiaoBanViewController.h"
#import "ContactBean.h"
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
#import "LDCalendarView.h"

@interface TiaoBanViewController ()
@property(nonatomic,copy)NSString *huanbanUserId;//换班人userId;
@property(nonatomic,copy)NSString *courtesyCopyId;//抄送人ID;
@property(nonatomic,copy)NSString *onelevelId;//1级审批人ID;
@property(nonatomic,copy)NSString *twolevelId;//2级审批人ID;
@property(nonatomic,copy)NSString *threelevelId;//3级审批人ID;

@property (nonatomic, strong)LDCalendarView    *calendarView1;//日历控件
@property (nonatomic, strong)LDCalendarView    *calendarView2;//日历控件
@property (nonatomic, strong)NSMutableArray *oldTimeArray;//原定时间
@property (nonatomic, strong)NSMutableArray *nowTimeArray;//调班时间
@end

@implementation TiaoBanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.courtesyCopyId=@"0";
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(selectUserHuanBan:) name:@"selectUserHuanBan" object:nil];
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

#pragma  mark 获取换班人信息
-(void)selectUserHuanBan:(id)sender{
    ContactBean *bean=[sender object];
    [self.huanbanrenText setText:bean.name];
    self.huanbanUserId=bean.id;
}

#pragma  mark 获取抄送人信息
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

- (IBAction)huanbanrenClick:(id)sender {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"MailList" bundle:nil];
    MailListViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"mailList"];
    controller.isFromSelect=YES;
    controller.isFromTiaoBan=YES;
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)orginTimeClick:(id)sender {
    [self selectDateTime:self.calendarView1 withArray:self.oldTimeArray atTextField:self.orginTimeText];
}
- (IBAction)tiaobanTimeClick:(id)sender {
    [self selectDateTime:self.calendarView2 withArray:self.nowTimeArray atTextField:self.tiaobanTimeText];
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
-(void)selectDateTime:(LDCalendarView *)calendarView withArray:(NSMutableArray *)array atTextField:(UITextField *)textField{
//    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
//    dateFormatter.dateFormat=@"yyyy-MM-dd";
//    WYBirthdayPickerView *datePickerView = [[WYBirthdayPickerView alloc] initWithInitialDate:[dateFormatter stringFromDate:[NSDate date]]andDateFormatter:@"yyyy-MM-dd"];
//    // 选择日期完成之后的回调 : 按自己的要求做相应的处理就可以了
//    datePickerView.confirmBlock = ^(NSString *selectedDate) {
//        textField.text=selectedDate;
//
//    };
//
//    [self.view addSubview:datePickerView];
    calendarView.defaultDays = array;
    
    [calendarView show:textField ];
}
#pragma mark 获取审批人
-(void)getShenPiRen{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *userId=[userDefault objectForKey:@"userId"];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"oaCustom/gotoInTransfer.do",apikey];
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
    if(self.huanbanrenText.text.length>0&&
       self.orginTimeText.text.length>0&&
       self.tiaobanTimeText.text.length>0&&
       self.reasonText.text.length>0){
        return YES;
    }else{
        return NO;
    }
}
#pragma mark 提交调班
-(void)submit{
    [MBProgressHUD showMessage:@"正在提交..."];
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *userId=[userDefault objectForKey:@"userId"];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"oaCustom/launchTansfer.do",apikey];
    
    NSDictionary *temp=@{@"userId":userId,
                         @"transferId":self.huanbanUserId,
                         @"incident":self.reasonText.text,
                         @"oldWorkDate":self.orginTimeText.text,
                         @"newWorkDate":self.tiaobanTimeText.text,
                         @"courtesyCopyId":self.courtesyCopyId
                         };
    NSMutableDictionary *params=[temp mutableCopy];
    if(self.onelevelId){
        [params setValue:self.onelevelId forKey:@"onelevelId"];
        [params setValue:self.onelevelId forKey:@"nowlevelId"];
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

- (LDCalendarView *)calendarView1 {
    if (!_calendarView1) {
        _calendarView1 = [[LDCalendarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
        [self.view addSubview:_calendarView1];

        __weak typeof(self) weakSelf = self;
        _calendarView1.complete = ^(NSArray *result, UITextField *textField) {
            if (result) {

                    weakSelf.oldTimeArray = result.mutableCopy;


                [weakSelf showStr:textField ];
            }
        };
    }
    return _calendarView1;
}
- (LDCalendarView *)calendarView2 {
    if (!_calendarView2) {
        _calendarView2 = [[LDCalendarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
        [self.view addSubview:_calendarView2];
        
        __weak typeof(self) weakSelf = self;
        _calendarView2.complete = ^(NSArray *result, UITextField *textField) {
            if (result) {
                
                weakSelf.nowTimeArray = result.mutableCopy;
                
                
                [weakSelf showStr:textField ];
            }
        };
    }
    return _calendarView2;
}
- (void)showStr:(UITextField *)textField{
    if(textField==self.orginTimeText){
        NSString *str = @"";
        //从小到大排序
        [self.oldTimeArray sortUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
            return [obj1 compare:obj2];
        }];
        
        for (int i=0;i<self.oldTimeArray.count;i++) {
            NSNumber *interval=self.oldTimeArray[i];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval.doubleValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MM-dd"];
            NSString *dateString = [formatter stringFromDate: date];
            
            if(i==0){
                str=dateString;
            }else{
                str=[NSString stringWithFormat:@"%@,%@",str,dateString];
            }
        }
        [textField setText:str];
    }else{
        NSString *str = @"";
        //从小到大排序
        [self.nowTimeArray sortUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
            return [obj1 compare:obj2];
        }];
        
        for (int i=0;i<self.nowTimeArray.count;i++) {
            NSNumber *interval=self.nowTimeArray[i];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval.doubleValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MM-dd"];
            NSString *dateString = [formatter stringFromDate: date];
            
            if(i==0){
                str=dateString;
            }else{
                str=[NSString stringWithFormat:@"%@,%@",str,dateString];
            }
        }
        [textField setText:str];
    }
    
}
@end
