//
//  ShenGouTableViewCell.m
//  wyoa
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "ShenGouTableViewCell.h"
#import  "UIImageView+WebCache.h"
@implementation ShenGouTableViewCell

-(void)setShenggouDetailBean:(ShengGouDetailBean *)shenggouDetailBean{
    if(shenggouDetailBean.nowSex &&[shenggouDetailBean.nowSex isEqualToString:@"女"]){
        [self.headImageView   sd_setImageWithURL:shenggouDetailBean.nowPhoto placeholderImage:[UIImage   imageNamed:@"woman"]];
    }else{
        [self.headImageView   sd_setImageWithURL:shenggouDetailBean.nowPhoto placeholderImage:[UIImage   imageNamed:@"man"]];
    }
    [self.nameLabel setText:[NSString stringWithFormat:@"%@的物品申购",shenggouDetailBean.realname]];
    [self.createDateLabel setText:shenggouDetailBean.fillformDate];
    [self.applyDateLabel setText:[NSString stringWithFormat:@"申请时间：%@",shenggouDetailBean.fillformDate]];
    [self.wupinLabel setText:[NSString stringWithFormat:@"申购物品：%@",shenggouDetailBean.buyItems]];
    [self.stateLabel setText:shenggouDetailBean.appStatus];
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
