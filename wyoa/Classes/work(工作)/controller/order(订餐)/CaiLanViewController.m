//
//  CaiLanViewController.m
//  wyoa
//
//  Created by apple on 2018/8/19.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "CaiLanViewController.h"
#import "CaiLanTableViewCell.h"
@interface CaiLanViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CaiLanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.tableView registerNib:[UINib nibWithNibName:@"CaiLanTableViewCell" bundle:nil] forCellReuseIdentifier:@"cailan"];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)buy{
    NSLog(@"购买。。。。。");
}
- (void)viewDidAppear:(BOOL)animated{
    UILabel *label=[[UILabel alloc]init];
    label.text=@"我的菜篮";
    label.textColor=[UIColor colorWithHexString:@"333333"];;
    label.font=[UIFont systemFontOfSize:20.0f];
    self.tabBarController.navigationItem.titleView=label;
    
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithTitle:@"购买" style:(UIBarButtonItemStyleDone) target:self action:@selector(buy)];
    self.tabBarController.navigationItem.rightBarButtonItem = rightitem;
    [self.tabBarController.navigationItem.rightBarButtonItem setTintColor:kThemeColor];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cailan";
    // 1.缓存中取
    CaiLanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[CaiLanTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //跳转到详情
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 155.0f;
}

@end
