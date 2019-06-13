//
//  BaoXiuTableViewCell.m
//  wyoa
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "BaoXiuTableViewCell.h"
#import  "UIImageView+WebCache.h"
@implementation BaoXiuTableViewCell

-(void)setBaoxiuDetailBean:(BaoXiuDetailBean *)baoxiuDetailBean{
    if(baoxiuDetailBean.nowSex &&[baoxiuDetailBean.nowSex isEqualToString:@"女"]){
        [self.headImageView   sd_setImageWithURL:baoxiuDetailBean.nowPhoto placeholderImage:[UIImage   imageNamed:@"woman"]];
    }else{
        [self.headImageView   sd_setImageWithURL:baoxiuDetailBean.nowPhoto placeholderImage:[UIImage   imageNamed:@"man"]];
    }
    [self.nameLabel setText:[NSString stringWithFormat:@"%@的报修",baoxiuDetailBean.realname]];
    [self.createDateLabel setText:baoxiuDetailBean.fillformDate];
    [self.expectDateLabel setText:[NSString stringWithFormat:@"期望时间：%@",baoxiuDetailBean.expectfixDate]];
    [self.wupinLabel setText:[NSString stringWithFormat:@"维修物品：%@",baoxiuDetailBean.fixItems]];
    [self.stateLabel setText:baoxiuDetailBean.appStatus];
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
