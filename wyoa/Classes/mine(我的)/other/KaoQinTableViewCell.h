//
//  KaoQinTableViewCell.h
//  wyoa
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KaoQinDetailBean.h"
@interface KaoQinTableViewCell : UITableViewCell
@property(nonatomic,strong)KaoQinDetailBean *kaoqinDetailBean;
@property (weak, nonatomic) IBOutlet UILabel *DuteDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *onTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *offTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *clockOnTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *clockOffTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *minAttendLabel;
@property (weak, nonatomic) IBOutlet UILabel *onStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *offStateLabel;

@end
