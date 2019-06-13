//
//  KaoQinTableViewCell.m
//  wyoa
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "KaoQinTableViewCell.h"
#import "TimeUtil.h"

@implementation KaoQinTableViewCell

-(void)setKaoqinDetailBean:(KaoQinDetailBean *)kaoqinDetailBean{
    [self.DuteDateLabel setText:kaoqinDetailBean.onDutyDate];
    [self.onTimeLabel setText:[TimeUtil detailDayToSimpleTime:kaoqinDetailBean.onTime]];
    [self.offTimeLabel setText:[TimeUtil detailDayToSimpleTime:kaoqinDetailBean.offTime]];
    [self.clockOnTimeLabel setText:[TimeUtil detailDayToSimpleTime:kaoqinDetailBean.clockOnTime]];
     [self.clockOffTimeLabel setText:[TimeUtil detailDayToSimpleTime:kaoqinDetailBean.clockOffTime]];
    [self.minAttendLabel setText:[TimeUtil MinutetransferToHourMin:kaoqinDetailBean.minAttend]];
    
    if([kaoqinDetailBean.onStatus containsString:@"正常"]){
        [self.onStateLabel setTextColor:[UIColor colorWithHexString:@"34BC33"]];
    }else{
        [self.onStateLabel setTextColor:[UIColor colorWithHexString:@"DA161E"]];
    }
    if([kaoqinDetailBean.offStatus containsString:@"正常"]){
        [self.offStateLabel setTextColor:[UIColor colorWithHexString:@"34BC33"]];
    }else{
        [self.offStateLabel setTextColor:[UIColor colorWithHexString:@"DA161E"]];
    }
    [self.onStateLabel setText:kaoqinDetailBean.onStatus];
    [self.offStateLabel setText:kaoqinDetailBean.offStatus];
    if([kaoqinDetailBean.onStatus containsString:@"迟到"]){
         [self.onStateLabel setText:[NSString stringWithFormat:@"%@%@",kaoqinDetailBean.onStatus,[TimeUtil MinutetransferToHourMin:kaoqinDetailBean.minuteLate]]];
    }
    if([kaoqinDetailBean.offStatus containsString:@"早退"]){
          [self.offStateLabel setText:[NSString stringWithFormat:@"%@%@",kaoqinDetailBean.offStatus,[TimeUtil MinutetransferToHourMin:kaoqinDetailBean.minLeave]]];
    }
   
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
