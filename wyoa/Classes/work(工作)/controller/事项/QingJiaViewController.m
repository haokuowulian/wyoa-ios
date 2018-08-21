//
//  QingJiaViewController.m
//  wyoa
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "QingJiaViewController.h"
#import <JXTAlertManager/JXTAlertManagerHeader.h>
#import "WYDateTimePickerView.h"

@interface QingJiaViewController ()

@end

@implementation QingJiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)typeClick:(id)sender {
    [self jxt_showActionSheetWithTitle:@"请选择请假类型" message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
        alertMaker.
        addActionCancelTitle(@"取消").
        addActionDestructiveTitle(@"公假").
        addActionDestructiveTitle(@"病假").
        addActionDestructiveTitle(@"事假").
        addActionDestructiveTitle(@"其它");
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
        if ([action.title isEqualToString:@"公假"]) {
            [self.typeText setText:@"公假"];
        }
        else if ([action.title isEqualToString:@"病假"]) {
            [self.typeText setText:@"病假"];
        }
        else if ([action.title isEqualToString:@"事假"]) {
            [self.typeText setText:@"事假"];
        }
        else if ([action.title isEqualToString:@"其它"]) {
            [self.typeText setText:@"其它"];
        }
    }];
}
- (IBAction)startTimeClick:(id)sender {
    [self selectDateTime:self.startTimeText];
}
- (IBAction)endTimeClick:(id)sender {
     [self selectDateTime:self.endTimeText];
}
- (IBAction)addChaoSongRen:(id)sender {
}

- (IBAction)submitClick:(id)sender {
}


#pragma mark 时间选择
-(void)selectDateTime:(UITextField *)textField{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    dateFormatter.dateFormat=@"yyyy-MM-dd HH:mm";
    WYDateTimePickerView *datePickerView = [[WYDateTimePickerView alloc] initWithInitialDate:[dateFormatter stringFromDate:[NSDate date]]];
    // 选择日期完成之后的回调 : 按自己的要求做相应的处理就可以了
    datePickerView.confirmBlock = ^(NSString *selectedDate) {
       textField.text=selectedDate;
        
    };
    
    [self.view addSubview:datePickerView];
}

#pragma mark 获取审批人
-(void)getShenPiRen{
    
}
@end
