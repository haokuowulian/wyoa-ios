//
//  StaffDetailViewController.h
//  wyoa
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StaffDetailBean.h"

@interface StaffDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *quxiangLabel;

@property(nonatomic,strong)StaffDetailBean *staffDetailBean;
@end
