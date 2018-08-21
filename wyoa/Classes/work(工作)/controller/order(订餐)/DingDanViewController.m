//
//  DingDanViewController.m
//  wyoa
//
//  Created by apple on 2018/8/19.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "DingDanViewController.h"
#import "WYDateTimePickerView.h"

@interface DingDanViewController ()

@end

@implementation DingDanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated{
    UILabel *label=[[UILabel alloc]init];
    label.text=@"订单";
    label.textColor=[UIColor colorWithHexString:@"333333"];;
    label.font=[UIFont systemFontOfSize:20.0f];
    self.tabBarController.navigationItem.titleView=label;
    
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithTitle:@"金额汇总" style:(UIBarButtonItemStyleDone) target:self action:@selector(buy)];
    self.tabBarController.navigationItem.rightBarButtonItem = rightitem;
    [self.tabBarController.navigationItem.rightBarButtonItem setTintColor:kThemeColor];
}


- (IBAction)startTimeClick:(id)sender {
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    dateFormatter.dateFormat=@"yyyy-MM-dd HH:mm";
    WYDateTimePickerView *datePickerView = [[WYDateTimePickerView alloc] initWithInitialDate:[dateFormatter stringFromDate:[NSDate date]]];
    // 选择日期完成之后的回调 : 按自己的要求做相应的处理就可以了
    datePickerView.confirmBlock = ^(NSString *selectedDate) {
        self.startTimeText.text=selectedDate;
        
    };
    
    [self.view addSubview:datePickerView];
}

- (IBAction)endTimeClick:(id)sender {
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    dateFormatter.dateFormat=@"yyyy-MM-dd HH:mm";
    WYDateTimePickerView *datePickerView = [[WYDateTimePickerView alloc] initWithInitialDate:[dateFormatter stringFromDate:[NSDate date]]];
    // 选择日期完成之后的回调 : 按自己的要求做相应的处理就可以了
    datePickerView.confirmBlock = ^(NSString *selectedDate) {
        self.endTimeText.text=selectedDate;
        
    };
    
    [self.view addSubview:datePickerView];
}
@end
