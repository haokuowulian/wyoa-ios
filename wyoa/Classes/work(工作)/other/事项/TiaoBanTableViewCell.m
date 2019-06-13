//
//  TiaoBanTableViewCell.m
//  wyoa
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "TiaoBanTableViewCell.h"
#import "TimeUtil.h"
#import  "UIImageView+WebCache.h"
@implementation TiaoBanTableViewCell


-(void)setTiaobanDetailBean:(TiaoBanDetailBean *)tiaobanDetailBean{
    if(tiaobanDetailBean.transferSex &&[tiaobanDetailBean.transferSex isEqualToString:@"女"]){
        [self.headImageView   sd_setImageWithURL:tiaobanDetailBean.nowPhoto placeholderImage:[UIImage   imageNamed:@"woman"]];
    }else{
        [self.headImageView   sd_setImageWithURL:tiaobanDetailBean.nowPhoto placeholderImage:[UIImage   imageNamed:@"man"]];
    }
    [self.nameLabel setText:[NSString stringWithFormat:@"%@的调班",tiaobanDetailBean.realname]];
    [self.createDateLabel setText:[TimeUtil detailDayToSimpleTime2:tiaobanDetailBean.createDate]];
    [self.oldDateLabel setText:[NSString stringWithFormat:@"开始时间：%@",tiaobanDetailBean.oldWorkDate]];
    [self.nowDateLabel setText:[NSString stringWithFormat:@"调至时间：%@",tiaobanDetailBean.nowWorkDate]];
    if(tiaobanDetailBean.state&&tiaobanDetailBean.state.length>0){
        if([tiaobanDetailBean.state isEqualToString:@"0"]){
            [self.stateLabel setText: @"待审批"];
        }else if([tiaobanDetailBean.state isEqualToString:@"1"]){
            [self.stateLabel setText: @"审批中"];
        }else if([tiaobanDetailBean.state isEqualToString:@"2"]){
            [self.stateLabel setText: @"审批通过"];
        }else if([tiaobanDetailBean.state isEqualToString:@"3"]){
            [self.stateLabel setText: @"审批已拒绝"];
        }
    }
   
    if(tiaobanDetailBean.appStatus&&tiaobanDetailBean.appStatus.length>0){
        [self.stateLabel setText: tiaobanDetailBean.appStatus];
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
