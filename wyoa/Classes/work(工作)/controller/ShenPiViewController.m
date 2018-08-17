//
//  ShenPiViewController.m
//  wyoa
//
//  Created by apple on 2018/8/15.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "ShenPiViewController.h"
#import "HangYeNewsViewController.h"
#import "LatestGongGaoViewController.h"
#import "MeetingTongZhiViewController.h"
@interface ShenPiViewController ()

@end

@implementation ShenPiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //取消返回文字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    [self setSegment];
    [self setTabedSlide];
    
  

   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


-(void)setSegment{
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:nil];
    
    
    segmentedControl.tintColor = kThemeColor; //渲染色彩
    [segmentedControl insertSegmentWithTitle:@"待我审批"atIndex:0 animated:YES];
    [segmentedControl insertSegmentWithTitle:@"我发起的"atIndex:1 animated:YES];
    [segmentedControl insertSegmentWithTitle:@"抄送我的"atIndex:2 animated:YES];
    segmentedControl.selectedSegmentIndex = 0; //初始指定第0个选中
    [segmentedControl setWidth:(kScreenWidth-48)/3 forSegmentAtIndex:0];
    [segmentedControl setWidth:(kScreenWidth-48)/3 forSegmentAtIndex:1];
    [segmentedControl setWidth:(kScreenWidth-48)/3 forSegmentAtIndex:2];
    
    segmentedControl.tintColor = [UIColor clearColor];//去掉颜色,现在整个segment都看不见
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],
                                             NSForegroundColorAttributeName: kThemeColor};
    [segmentedControl setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],
                                               NSForegroundColorAttributeName: [UIColor colorWithHexString:@"999999"]};
    [segmentedControl setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    [self.navigationItem setTitleView:segmentedControl];
}

-(void)setTabedSlide{
    self.tabedSlideView.baseViewController = self;
    self.tabedSlideView.delegate=self;
    self.tabedSlideView.tabItemNormalColor = [UIColor colorWithHexString:@"999999"];
    self.tabedSlideView.tabItemSelectedColor = [UIColor colorWithHexString:@"1296eb"];
    self.tabedSlideView.tabbarTrackColor = [UIColor colorWithHexString:@"1296eb"];
    self.tabedSlideView.tabbarBottomSpacing = 3.0;
    
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
            HangYeNewsViewController *ctrl = [[HangYeNewsViewController alloc] init];
            return ctrl;
        }
        case 1:
        {
            LatestGongGaoViewController *ctrl = [[LatestGongGaoViewController alloc] init];
            return ctrl;
        }
        case 2:
        {
            MeetingTongZhiViewController *ctrl = [[MeetingTongZhiViewController alloc] init];
            return ctrl;
        }
        case 3:
        {
            HangYeNewsViewController *ctrl = [[HangYeNewsViewController alloc] init];
            return ctrl;
        }
        case 4:
        {
            LatestGongGaoViewController *ctrl = [[LatestGongGaoViewController alloc] init];
            return ctrl;
        }
        case 5:
        {
            MeetingTongZhiViewController *ctrl = [[MeetingTongZhiViewController alloc] init];
            return ctrl;
        }
        default:
            return nil;
    }
}
@end
