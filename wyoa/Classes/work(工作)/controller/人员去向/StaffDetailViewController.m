//
//  StaffDetailViewController.m
//  wyoa
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "StaffDetailViewController.h"

@interface StaffDetailViewController ()

@end

@implementation StaffDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nameLabel setText:self.staffDetailBean.name];
    [self.startDateLabel setText:self.staffDetailBean.startDate];
    [self.endDateLabel setText:self.staffDetailBean.endDate];
    [self.quxiangLabel setText:self.staffDetailBean.location];
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

@end
