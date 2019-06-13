//
//  LingYongTableViewCell.m
//  wyoa
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "LingYongTableViewCell.h"
#import  "UIImageView+WebCache.h"
@implementation LingYongTableViewCell

-(void)setLingyongDetailBean:(LingYongDetailBean *)lingyongDetailBean{
    if(lingyongDetailBean.user.sex &&[lingyongDetailBean.user.sex isEqualToString:@"女"]){
        [self.headImageView   sd_setImageWithURL:lingyongDetailBean.userInfo.headPhoto placeholderImage:[UIImage   imageNamed:@"woman"]];
    }else{
        [self.headImageView   sd_setImageWithURL:lingyongDetailBean.userInfo.headPhoto placeholderImage:[UIImage   imageNamed:@"man"]];
    }
    [self.nameLabel setText:[NSString stringWithFormat:@"%@的物品领用",lingyongDetailBean.realname]];
    [self.createDateLabel setText:lingyongDetailBean.fillformDate];
    [self.wupinLabel setText:[NSString stringWithFormat:@"物品名称：%@",lingyongDetailBean.items_name]];
    [self.useLabel setText:[NSString stringWithFormat:@"物品用途：%@",lingyongDetailBean.incident]];
    [self.stateLabel setText:lingyongDetailBean.appState];
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
