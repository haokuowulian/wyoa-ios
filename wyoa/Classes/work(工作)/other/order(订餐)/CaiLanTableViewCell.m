//
//  CaiLanTableViewCell.m
//  wyoa
//
//  Created by apple on 2018/8/19.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "CaiLanTableViewCell.h"

@implementation CaiLanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.checkBox setOn:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
