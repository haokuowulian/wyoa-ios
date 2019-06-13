//
//  AboutShenPiViewController.m
//  wyoa
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "AboutShenPiViewController.h"
#import "ShenPiViewController.h"
#import "FaQiViewController.h"
#import "ChaoSongViewController.h"
@interface AboutShenPiViewController ()
@property(nonatomic,strong)UIViewController *currentVC;
@property(nonatomic,strong)ShenPiViewController *firstVC;
@property(nonatomic,strong)FaQiViewController *secondVC;
@property(nonatomic,strong)ChaoSongViewController *thirdVC;
@end

@implementation AboutShenPiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"ShenPi" bundle:nil];
    self.firstVC= [storyboard instantiateViewControllerWithIdentifier:@"shenpi"];
    [self addChildViewController:self.firstVC];
    
    UIStoryboard *storyboard2=[UIStoryboard storyboardWithName:@"FaQi" bundle:nil];
    self.secondVC= [storyboard2 instantiateViewControllerWithIdentifier:@"faqi"];
    [self addChildViewController:_secondVC];
    
    UIStoryboard *storyboard3=[UIStoryboard storyboardWithName:@"ChaoSong" bundle:nil];
    self.thirdVC= [storyboard3 instantiateViewControllerWithIdentifier:@"chaosong"];
    [self addChildViewController:_thirdVC];
    
    //设置默认控制器为fristVc
    self.currentVC = self.firstVC;
    [self.view addSubview:self.firstVC.view];
      [self setSegment];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [segmentedControl addTarget:self action:@selector(changeSegment:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.selectedSegmentIndex = 0;
//    [self changeSegment:segmentedControl];
    [self.navigationItem setTitleView:segmentedControl];
}
#pragma mark 切换segment
-(void)changeSegment:(UISegmentedControl *)sender{
    if (sender.selectedSegmentIndex == 0) {
        [self replaceFromOldViewController:self.currentVC toNewViewController:self.firstVC];
    }else if (sender.selectedSegmentIndex == 1){
         [self replaceFromOldViewController:self.currentVC toNewViewController:self.secondVC];
    }else if (sender.selectedSegmentIndex == 2){
         [self replaceFromOldViewController:self.currentVC toNewViewController:self.thirdVC];
    }
}


 #pragma mark 实现控制器的切换
- (void)replaceFromOldViewController:(UIViewController *)oldVc toNewViewController:(UIViewController *)newVc{
    /**
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController    当前显示在父视图控制器中的子视图控制器
     *  toViewController        将要显示的姿势图控制器
     *  duration                动画时间(这个属性,old friend 了 O(∩_∩)O)
     *  options              动画效果(渐变,从下往上等等,具体查看API)UIViewAnimationOptionTransitionCrossDissolve
     *  animations            转换过程中得动画
     *  completion            转换完成
     */
    [self addChildViewController:newVc];
    [self transitionFromViewController:oldVc toViewController:newVc duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        if (finished) {
            [newVc didMoveToParentViewController:self];
            [oldVc willMoveToParentViewController:nil];
            [oldVc removeFromParentViewController];
            self.currentVC = newVc;
        }else{
            self.currentVC = oldVc;
        }
    }];
}
@end
