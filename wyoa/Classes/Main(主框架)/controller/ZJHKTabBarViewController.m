//
//  ZJHKTabBarViewController.m
//  wjlx
//
//  Created by apple on 2018/7/11.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "ZJHKTabBarViewController.h"
#import "ZJHKTabBarbutton.h"
@interface ZJHKTabBarViewController ()


@property(nonatomic,weak) ZJHKTabBarbutton *_previousBtn; //自定义的覆盖原先的tarbar的控件

@end

@implementation ZJHKTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //获取4个子控制器
    UIViewController *v1=[self loadSubViewControllerWithSBName:@"Message"];
    UIViewController *v2=[self loadSubViewControllerWithSBName:@"Work"];
    UIViewController *v3=[self loadSubViewControllerWithSBName:@"MailList"];
    UIViewController *v4=[self loadSubViewControllerWithSBName:@"Mine"];
    //tabbarController设置子控制器
//    NSArray *array = @[v1,v2,v3,v4];
    
    self.viewControllers = @[v1,v2,v3,v4];
    
    //创建自定义的tabbar
    self.tabbar=[[UIView alloc]init];
    //设置tabbar的frame为系统的frame
    self.tabbar.frame=self.tabBar.bounds;
    self.tabbar.backgroundColor=[UIColor whiteColor];
    [self.tabBar addSubview:self.tabbar];
    // 下面的方法是调用自定义的生成按钮的方法
        [self creatButtonWithNormalName:@"news"andSelectName:@"news1"andTitle:@"消息"andIndex:0];
       [self creatButtonWithNormalName:@"work1"andSelectName:@"work"andTitle:@"工作"andIndex:1];
       [self creatButtonWithNormalName:@"tongxun"andSelectName:@"tongxun1"andTitle:@"通讯录"andIndex:2];
        [self creatButtonWithNormalName:@"my"andSelectName:@"my1"andTitle:@"我的"andIndex:3];
   
        ZJHKTabBarbutton *btn = self.tabbar.subviews[1];
    
      [self changeViewController:btn]; //自定义的控件中的按钮被点击了调用的方法，默认进入界面就选中第一个按钮

  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//根据sb名字放回控制器
-(UIViewController *)loadSubViewControllerWithSBName:(NSString *)name{
    //获取sb对象
    UIStoryboard *sb=[UIStoryboard storyboardWithName:name bundle:nil];
    return [sb instantiateInitialViewController];
    
}

#pragma mark 创建一个按钮
- (void)creatButtonWithNormalName:(NSString *)normal andSelectName:(NSString *)selected andTitle:(NSString *)title andIndex:(int)index
 {
     
   
        ZJHKTabBarbutton *button = [ZJHKTabBarbutton buttonWithType:UIButtonTypeCustom];
       button.tag = index;
   
   
        CGFloat W = kScreenWidth/ 4;
        CGFloat H = 52.5;
        CGFloat X=W*index;
        CGFloat Y=0;
        button.frame = CGRectMake(X, Y,W, H);
   
   
        [button setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:selected] forState:UIControlStateDisabled];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:kGray999999Color forState:(UIControlState)UIControlStateNormal];
        [button setTitleColor:kThemeColor forState:(UIControlState)UIControlStateDisabled];
        [button addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchDown];
   
        button.imageView.contentMode = UIViewContentModeCenter; // 让图片在按钮内居中
        button.titleLabel.textAlignment = NSTextAlignmentCenter; // 让标题在按钮内居中
        button.font = [UIFont systemFontOfSize:10]; // 设置标题的字体大小
   
        [self.tabbar addSubview:button];
     }

 #pragma mark 按钮被点击时调用
 - (void)changeViewController:(ZJHKTabBarbutton *)sender
 {
     self.selectedIndex = sender.tag; //切换不同控制器的界面
    
       sender.enabled = NO;
     
         if (self._previousBtn != sender) {
      
                self._previousBtn.enabled = YES;
         
             }
    
        self._previousBtn = sender;
    
    }


@end
