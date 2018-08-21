//
//  DingCanViewController.m
//  wyoa
//
//  Created by apple on 2018/8/19.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "DingCanViewController.h"
#import "HWOptionButton.h"
#import "DingCanTableViewCell.h"

@interface DingCanViewController ()<HWOptionButtonDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) HWOptionButton *optionButton;

@end

@implementation DingCanViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.tableView registerNib:[UINib nibWithNibName:@"DingCanTableViewCell" bundle:nil] forCellReuseIdentifier:@"dingcan"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
- (void)viewDidAppear:(BOOL)animated{
      [self creatControl];
   self.tabBarController.navigationItem.titleView=self.optionButton;
    self.tabBarController.navigationItem.rightBarButtonItem = nil;

}
- (void)creatControl
{
    HWOptionButton *optionBtn = [[HWOptionButton alloc] initWithFrame:CGRectMake(50, 100, 110, 44)];
    optionBtn.array = @[@"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", @"星期日"];
    optionBtn.delegate = self;
    optionBtn.showSearchBar = NO;
    self.optionButton = optionBtn;
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"dingcan";
    // 1.缓存中取
    DingCanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[DingCanTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //跳转到详情
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0f;
}
@end
