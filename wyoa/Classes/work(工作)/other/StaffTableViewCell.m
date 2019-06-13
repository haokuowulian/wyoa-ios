//
//  StaffTableViewCell.m
//  wyoa
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "StaffTableViewCell.h"
#import  "UIImageView+WebCache.h"
#import "TimeUtil.h"

@implementation StaffTableViewCell

-(void)setStaffDetailBean:(StaffDetailBean *)staffDetailBean{
    if(staffDetailBean.sex &&[staffDetailBean.sex isEqualToString:@"女"]){
        [self.headImageView   sd_setImageWithURL:staffDetailBean.userInfo.headPhoto placeholderImage:[UIImage  imageNamed:@"woman"]];
    }else{
        [self.headImageView   sd_setImageWithURL:staffDetailBean.userInfo.headPhoto placeholderImage:[UIImage   imageNamed:@"man"]];
    }
    [self.nameLabel setText:[NSString stringWithFormat:@"%@的人员去向",staffDetailBean.name]];
    [self.sectionLabel setText:[NSString stringWithFormat:@"原属科室：%@",staffDetailBean.secition]];
     [self.locationLabel setText:[NSString stringWithFormat:@"人员去向：%@",staffDetailBean.location]];
     [self.startTimeLabel setText:[NSString stringWithFormat:@"开始时间：%@",staffDetailBean.startDate]];
     [self.endTimeLabel setText:[NSString stringWithFormat:@"结束时间：%@",staffDetailBean.endDate]];
    [self.createDateLabel setText:[TimeUtil detailDayToSimpleTime2:staffDetailBean.createDate]];
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
