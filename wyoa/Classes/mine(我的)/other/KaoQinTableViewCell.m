//
//  KaoQinTableViewCell.m
//  wyoa
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "KaoQinTableViewCell.h"

@implementation KaoQinTableViewCell

-(void)setKaoqinDetailBean:(KaoQinDetailBean *)kaoqinDetailBean{
    [self.DuteDateLabel setText:kaoqinDetailBean.onDutyDate];
    [self.onTimeLabel setText:kaoqinDetailBean.onTime];
    [self.offTimeLabel setText:kaoqinDetailBean.offTime];
    [self.clockOnTimeLabel setText:kaoqinDetailBean.clockOnTime];
    [self.clockOffTimeLabel setText:kaoqinDetailBean.clockOffTime];
    [self.minAttendLabel setText:kaoqinDetailBean.minAttend];
    [self.onStateLabel setText:kaoqinDetailBean.onStatus];
    [self.offStateLabel setText:kaoqinDetailBean.offStatus];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
