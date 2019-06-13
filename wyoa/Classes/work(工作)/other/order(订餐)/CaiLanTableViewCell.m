//
//  CaiLanTableViewCell.m
//  wyoa
//
//  Created by apple on 2018/8/19.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "CaiLanTableViewCell.h"
#import  "UIImageView+WebCache.h"
@implementation CaiLanTableViewCell

-(void)setCailanDetailBean:(CaiLanDetailbean *)cailanDetailBean{
    _cailanDetailBean=cailanDetailBean;
      [self.coverImageView   sd_setImageWithURL:cailanDetailBean.coverImage placeholderImage:[UIImage   imageNamed:@"img_food"]];
    [self.foodNameLabel setText:cailanDetailBean.foodName];
    [self.eatTimeLabel setText:[NSString stringWithFormat: @"用餐时间：%@",cailanDetailBean.eatTime]];
    [self.foodNumLabel setText:[NSString stringWithFormat: @"数量：%@",cailanDetailBean.num]];
    [self.foodPricerLabel setText:[NSString stringWithFormat:@"总价：￥%@",cailanDetailBean.total]];
    self.checkBox.delegate=self;
    self.checkBox.on=false;
}

- (void)awakeFromNib {
    [super awakeFromNib];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)didTapCheckBox:(BEMCheckBox *)sender{
    if (self.checkAction) {
        // 调用block传入参数
        self.checkAction(sender);
    }
}
- (IBAction)deleteClick:(id)sender {
    if (self.deleteAction) {
        // 调用block传入参数
        self.deleteAction(sender);
    }
}
@end
