//
//  GongChaiTableViewCell.m
//  wyoa
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "GongChaiTableViewCell.h"
#import  "UIImageView+WebCache.h"
@implementation GongChaiTableViewCell

-(void)setGongchaiDetailBean:(GongChaiDetailBean *)gongchaiDetailBean{
    if(gongchaiDetailBean.user.sex &&[gongchaiDetailBean.user.sex isEqualToString:@"女"]){
        [self.headImageView   sd_setImageWithURL:gongchaiDetailBean.userInfo.headPhoto placeholderImage:[UIImage   imageNamed:@"woman"]];
    }else{
        [self.headImageView   sd_setImageWithURL:gongchaiDetailBean.userInfo.headPhoto placeholderImage:[UIImage   imageNamed:@"man"]];
    }
    [self.nameLabel setText:[NSString stringWithFormat:@"%@的公差",gongchaiDetailBean.realname]];
    [self.createDateLabel setText:gongchaiDetailBean.fillformDate];
    [self.startDateLabel setText:[NSString stringWithFormat:@"开始时间：%@",gongchaiDetailBean.startDate]];
    [self.endDateLabel setText:[NSString stringWithFormat:@"结束时间：%@",gongchaiDetailBean.endDate]];
    if(gongchaiDetailBean.appState&&gongchaiDetailBean.appState.length>0){
        [self.stateLabel setText: gongchaiDetailBean.appState];
    }
    if(gongchaiDetailBean.appStatus&&gongchaiDetailBean.appStatus.length>0){
        [self.stateLabel setText: gongchaiDetailBean.appStatus];
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
