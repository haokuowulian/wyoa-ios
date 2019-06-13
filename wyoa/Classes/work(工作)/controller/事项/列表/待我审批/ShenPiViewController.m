//
//  ShenPiViewController.m
//  wyoa
//
//  Created by apple on 2018/8/15.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "ShenPiViewController.h"

#import "QingJiaNeedApprovalViewController.h"
#import "GongChaiNeedApprovalViewController.h"
#import "TiaoBanNeedApprovalViewController.h"
#import "ShengGouNeedApprovalViewController.h"
#import "BaoXiuNeedApprovalViewController.h"
#import "LingYongNeedApprovalViewController.h"
#import "TimeUtil.h"
#import "WYBirthdayPickerView.h"
#import "CJYearMonthSelectedView.h"



@interface ShenPiViewController ()
@property(nonatomic,strong)UIBarButtonItem *rightitem;
@end

@implementation ShenPiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //取消返回文字
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
//                                                         forBarMetrics:UIBarMetricsDefault];
   
     self.rightitem = [[UIBarButtonItem alloc] initWithTitle: [TimeUtil getCurrentMonth] style:(UIBarButtonItemStyleDone) target:self action:@selector(selectMonth)];
    self.navigationItem.rightBarButtonItem = self.rightitem;
    [self setTabedSlide];
    
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(getDate:) name:@"getDate" object:nil];


}
-(void)getDate:(id) sender{
    [self.rightitem setTitle:[sender object]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

-(void)selectMonth{
    [CJYearMonthSelectedView showDatePickerWithTitle:@"选择月份" minDateStr:@"1970-01" resultBlock:^(NSString *selectValue) {
        //选择完成后的操作
//        NSLog(@"selected month is %@", selectValue);
    }];
}

#pragma mark 设置滑动选项
-(void)setTabedSlide{
    self.tabedSlideView.baseViewController = self;
    self.tabedSlideView.delegate=self;
    self.tabedSlideView.tabItemNormalColor = [UIColor colorWithHexString:@"999999"];
    self.tabedSlideView.tabItemSelectedColor = [UIColor colorWithHexString:@"1296eb"];
    self.tabedSlideView.tabbarTrackColor = [UIColor colorWithHexString:@"1296eb"];
    self.tabedSlideView.tabbarBottomSpacing = 0.0;
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"事假" image:nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"公差" image:nil selectedImage:nil];
    DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"调班" image:nil selectedImage:nil];
    DLTabedbarItem *item4 = [DLTabedbarItem itemWithTitle:@"申购" image:nil selectedImage:nil];
    DLTabedbarItem *item5 = [DLTabedbarItem itemWithTitle:@"报修" image:nil selectedImage:nil];
    DLTabedbarItem *item6 = [DLTabedbarItem itemWithTitle:@"领用" image:nil selectedImage:nil];
    self.tabedSlideView.tabbarItems = @[item1, item2,item3,item4,item5,item6];
    [self.tabedSlideView buildTabbar];
    self.tabedSlideView.selectedIndex = 0;
}

- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
    return 6;
}
- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index{
    switch (index) {
        case 0:
        {
            UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"QingJiaNeedApproval" bundle:nil];
            QingJiaNeedApprovalViewController *ctrl = [storyboard instantiateViewControllerWithIdentifier:@"qingJiaNeedApproval"];
            ctrl.fillformDate=self.rightitem.title;
            return ctrl;
        }
        case 1:
        {
            UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"GongChaiNeedApproval" bundle:nil];
            GongChaiNeedApprovalViewController *ctrl = [storyboard instantiateViewControllerWithIdentifier:@"gongchaiNeedApproval"];
            ctrl.fillformDate=self.rightitem.title;
            return ctrl;
        }
        case 2:
        {
            UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"TiaoBanNeedApproval" bundle:nil];
            TiaoBanNeedApprovalViewController *ctrl = [storyboard instantiateViewControllerWithIdentifier:@"tiaobanNeedApproval"];
             ctrl.fillformDate=self.rightitem.title;
            return ctrl;
        }
        case 3:
        {
            UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"ShengGouNeedApproval" bundle:nil];
            ShengGouNeedApprovalViewController *ctrl = [storyboard instantiateViewControllerWithIdentifier:@"shenggouNeedApproval"];
             ctrl.fillformDate=self.rightitem.title;
            return ctrl;
        }
        case 4:
        {
            UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"BaoXiuNeedApproval" bundle:nil];
            BaoXiuNeedApprovalViewController *ctrl = [storyboard instantiateViewControllerWithIdentifier:@"baoxiuNeedApproval"];
             ctrl.fillformDate=self.rightitem.title;
            return ctrl;
        }
        case 5:
        {
            UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"LingYongNeedApproval" bundle:nil];
            LingYongNeedApprovalViewController *ctrl = [storyboard instantiateViewControllerWithIdentifier:@"lingyongNeedApproval"];
             ctrl.fillformDate=self.rightitem.title;
            return ctrl;
        }
        default:
            return nil;
    }
}
@end
