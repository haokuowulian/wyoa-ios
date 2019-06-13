//
//  MyOnDutyViewController.m
//  wyoa
//
//  Created by apple on 2018/10/29.
//  Copyright © 2018 zjf. All rights reserved.
//

#import "MyOnDutyViewController.h"
#import "FDCalendar.h"
@interface MyOnDutyViewController ()
@end

@implementation MyOnDutyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor=[UIColor whiteColor];
    FDCalendar *calendar = [[FDCalendar alloc] initWithCurrentDate:[NSDate date]];
    CGRect frame = calendar.frame;
    frame.origin.y = 32;
    calendar.frame = frame;
    [self.view addSubview:calendar];
   
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(getDate:) name:@"sendDate" object:nil];


}

-(void)getDate:(id)sender{
    NSDate *date=[sender object];
    NSLog(@"--------%@",date);
}
@end
