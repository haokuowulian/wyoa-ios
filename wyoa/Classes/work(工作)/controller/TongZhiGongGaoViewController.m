//
//  TongZhiGongGaoViewController.m
//  wyoa
//
//  Created by apple on 2018/8/14.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "TongZhiGongGaoViewController.h"
#import "DLFixedTabbarView.h"
#import "HangYeNewsViewController.h"
#import "LatestGongGaoViewController.h"
#import "MeetingTongZhiViewController.h"

@interface TongZhiGongGaoViewController ()

@end

@implementation TongZhiGongGaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabedSlideView.baseViewController = self;
    self.tabedSlideView.delegate=self;
    self.tabedSlideView.tabItemNormalColor = [UIColor colorWithHexString:@"999999"];
    self.tabedSlideView.tabItemSelectedColor = [UIColor colorWithHexString:@"1296eb"];
    self.tabedSlideView.tabbarTrackColor = [UIColor colorWithHexString:@"1296eb"];
    self.tabedSlideView.tabbarBottomSpacing = 3.0;
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"行业新闻" image:nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"最新公告" image:nil selectedImage:nil];
    DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"会议通知" image:nil selectedImage:nil];
    self.tabedSlideView.tabbarItems = @[item1, item2, item3];
    [self.tabedSlideView buildTabbar];
    
    self.tabedSlideView.selectedIndex = 0;
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
- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
    return 3;
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
            
        default:
            return nil;
    }
}
@end
