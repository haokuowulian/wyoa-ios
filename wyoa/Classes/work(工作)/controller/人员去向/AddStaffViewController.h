//
//  AddStaffViewController.h
//  wyoa
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StaffDetailBean.h"
@interface AddStaffViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
- (IBAction)nameClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *startDateLabel;
- (IBAction)startDateClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *endDateLabel;
- (IBAction)endDateClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *quxiangLabel;

- (IBAction)submitClick:(id)sender;

@property(nonatomic,strong)StaffDetailBean *staffDetailBean;
@property(nonatomic,strong)NSIndexPath *indexPath;
@end
