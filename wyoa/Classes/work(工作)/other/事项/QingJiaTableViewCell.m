//
//  QingJiaTableViewCell.m
//  wyoa
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "QingJiaTableViewCell.h"
#import  "UIImageView+WebCache.h"

@implementation QingJiaTableViewCell

-(void)setQingjiaDetailBean:(QingJiaDetailBean *)qingjiaDetailBean{
    if(qingjiaDetailBean.user.sex &&[qingjiaDetailBean.user.sex isEqualToString:@"女"]){
         [self.headImageView   sd_setImageWithURL:qingjiaDetailBean.userInfo.headPhoto placeholderImage:[UIImage   imageNamed:@"woman"]];
    }else{
         [self.headImageView   sd_setImageWithURL:qingjiaDetailBean.userInfo.headPhoto placeholderImage:[UIImage   imageNamed:@"man"]];
    }
    [self.nameLabel setText:[NSString stringWithFormat:@"%@的请假",qingjiaDetailBean.realname]];
    [self.createDateLabel setText:qingjiaDetailBean.fillformDate];
    [self.startDateLabel setText:[NSString stringWithFormat:@"开始时间：%@",qingjiaDetailBean.startDate]];
     [self.endDateLabel setText:[NSString stringWithFormat:@"结束时间：%@",qingjiaDetailBean.endDate]];
    if(qingjiaDetailBean.appState&&qingjiaDetailBean.appState.length>0){
        [self.stateLabel setText: qingjiaDetailBean.appState];
    }
    if(qingjiaDetailBean.appStatus&&qingjiaDetailBean.appStatus.length>0){
        [self.stateLabel setText: qingjiaDetailBean.appStatus];
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
