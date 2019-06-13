//
//  DingCanTableViewCell.m
//  wyoa
//
//  Created by apple on 2018/8/19.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "DingCanTableViewCell.h"
#import  "UIImageView+WebCache.h"
@implementation DingCanTableViewCell
-(void)setDingcanDetailBean:(DingCanDetailBean *)dingcanDetailBean{
    [self.picImageView   sd_setImageWithURL:dingcanDetailBean.coverImage placeholderImage:[UIImage   imageNamed:@"img_food"]];
    [self.nameLabel setText: dingcanDetailBean.foodName];
    [self.priceLabel setText:[NSString stringWithFormat:@"￥%@",dingcanDetailBean.foodPrice]];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)addClick:(id)sender {
    if (self.addAction) {
        // 调用block传入参数
        self.addAction(sender);
    }
}
@end

