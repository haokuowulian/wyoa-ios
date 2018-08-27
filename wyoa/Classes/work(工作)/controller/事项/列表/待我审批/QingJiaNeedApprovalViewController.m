//
//  QingJiaNeedApprovalViewController.m
//  wyoa
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "QingJiaNeedApprovalViewController.h"

@interface QingJiaNeedApprovalViewController ()
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,strong)NSMutableArray *qingjiaArray;
@end

@implementation QingJiaNeedApprovalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
