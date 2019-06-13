//
//  ChaoSongViewController.m
//  wyoa
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "ChaoSongViewController.h"
#import "QingJiaChaoSongViewController.h"
#import "GongChaiChaoSongViewController.h"
#import "TiaoBanChaoSongViewController.h"
#import "ShengGouChaoSongViewController.h"
#import "BaoXiuChaoSongViewController.h"
#import "LingYongChaoSongViewController.h"
#import "TimeUtil.h"
#import "CJYearMonthSelectedView.h"
@interface ChaoSongViewController ()
@property(nonatomic,strong)UIBarButtonItem *rightitem;
@end

@implementation ChaoSongViewController

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
            UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"QingJiaChaoSong" bundle:nil];
            QingJiaChaoSongViewController *ctrl = [storyboard instantiateViewControllerWithIdentifier:@"qingjiachaosong"];
             ctrl.fillformDate=self.rightitem.title;
            return ctrl;
        }
        case 1:
        {
            UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"GongChaiChaoSong" bundle:nil];
            GongChaiChaoSongViewController *ctrl = [storyboard instantiateViewControllerWithIdentifier:@"gongchaichaosong"];
             ctrl.fillformDate=self.rightitem.title;
            return ctrl;
        }
        case 2:
        {
            UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"TiaoBanChaoSong" bundle:nil];
            TiaoBanChaoSongViewController *ctrl = [storyboard instantiateViewControllerWithIdentifier:@"tiaobanchaosong"];
             ctrl.fillformDate=self.rightitem.title;
            return ctrl;
        }
        case 3:
        {
            UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"ShengGouChaoSong" bundle:nil];
            ShengGouChaoSongViewController *ctrl = [storyboard instantiateViewControllerWithIdentifier:@"shenggouchaosong"];
             ctrl.fillformDate=self.rightitem.title;
            return ctrl;
        }
        case 4:
        {
            UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"BaoXiuChaoSong" bundle:nil];
            BaoXiuChaoSongViewController *ctrl = [storyboard instantiateViewControllerWithIdentifier:@"baoxiuchaosong"];
             ctrl.fillformDate=self.rightitem.title;
            return ctrl;
        }
        case 5:
        {
            UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"LingYongChaoSong" bundle:nil];
            LingYongChaoSongViewController *ctrl = [storyboard instantiateViewControllerWithIdentifier:@"lingyongchaosong"];
             ctrl.fillformDate=self.rightitem.title;
            return ctrl;
        }
        default:
            return nil;
    }
}

@end
