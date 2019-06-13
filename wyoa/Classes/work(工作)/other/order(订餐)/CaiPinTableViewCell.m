//
//  CaiPinTableViewCell.m
//  wyoa
//
//  Created by apple on 2018/9/5.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "CaiPinTableViewCell.h"

@implementation CaiPinTableViewCell

-(void)setDingcanDetailBean:(DingCanDetailBean *)dingcanDetailBean{
    
    [self.caiNameLabel setText:dingcanDetailBean.foodName];
    [self.numLabel setText:[NSString stringWithFormat:@"X%ld",dingcanDetailBean.num]];
    NSDecimalNumber *danjia=[NSDecimalNumber decimalNumberWithString:dingcanDetailBean.foodPrice];
    NSDecimalNumber *shuliang=[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%ld",dingcanDetailBean.num]];
    NSDecimalNumber *result = [danjia decimalNumberByMultiplyingBy:shuliang];
    [self.priceLabel setText:[NSString stringWithFormat:@"￥%@",result] ];
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
