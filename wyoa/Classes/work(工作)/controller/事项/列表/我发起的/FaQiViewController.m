//
//  FaQiViewController.m
//  wyoa
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "FaQiViewController.h"
#import "MyQingJiaViewController.h"
#import "MyGongChaiViewController.h"
#import "MyTiaoBanViewController.h"
#import "MyShengGouViewController.h"
#import "MyBaoXiuViewController.h"
#import "MyLingYongViewController.h"
#import "CJYearMonthSelectedView.h"
#import "TimeUtil.h"
@interface FaQiViewController ()
@property(nonatomic,strong)UIBarButtonItem *rightitem;
@end

@implementation FaQiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self setTabedSlide];
    
    self.rightitem = [[UIBarButtonItem alloc] initWithTitle: [TimeUtil getCurrentMonth] style:(UIBarButtonItemStyleDone) target:self action:@selector(selectMonth)];
    self.navigationItem.rightBarButtonItem = self.rightitem;
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
    // Dispose of any resources that can be recreated.
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
            UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"MyQingJia" bundle:nil];
            MyQingJiaViewController *ctrl = [storyboard instantiateViewControllerWithIdentifier:@"myQingJia"];
            ctrl.fillformDate=self.rightitem.title;
            return ctrl;
        }
        case 1:
        {
            UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"MyGongChai" bundle:nil];
            MyGongChaiViewController *ctrl = [storyboard instantiateViewControllerWithIdentifier:@"myGongChai"];
            ctrl.fillformDate=self.rightitem.title;
            return ctrl;
        }
        case 2:
        {
            UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"MyTiaoBan" bundle:nil];
            MyTiaoBanViewController *ctrl = [storyboard instantiateViewControllerWithIdentifier:@"myTiaoBan"];
            ctrl.fillformDate=self.rightitem.title;
            return ctrl;
        }
        case 3:
        {
            UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"MyShengGou" bundle:nil];
            MyShengGouViewController *ctrl = [storyboard instantiateViewControllerWithIdentifier:@"myShengGou"];
            ctrl.fillformDate=self.rightitem.title;
            return ctrl;
        }
        case 4:
        {
            UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"MyBaoXiu" bundle:nil];
            MyBaoXiuViewController *ctrl = [storyboard instantiateViewControllerWithIdentifier:@"myBaoXiu"];
            ctrl.fillformDate=self.rightitem.title;
            return ctrl;
        }
        case 5:
        {
            UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"MyLingYong" bundle:nil];
            MyLingYongViewController *ctrl = [storyboard instantiateViewControllerWithIdentifier:@"myLingYong"];
            ctrl.fillformDate=self.rightitem.title;
            return ctrl;
        }
        default:
            return nil;
    }
}

@end
