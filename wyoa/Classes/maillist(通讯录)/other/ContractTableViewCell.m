//
//  ContractTableViewCell.m
//  wyoa
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "ContractTableViewCell.h"
#import  "UIImageView+WebCache.h"
@implementation ContractTableViewCell

-(void)setContractBean:(ContactBean *)contractBean{
    if([contractBean.sex isEqualToString:@"女"]){
        [self.headImageView   sd_setImageWithURL:contractBean.headPhoto placeholderImage:[UIImage   imageNamed:@"woman"]];
    }else{
         [self.headImageView   sd_setImageWithURL:contractBean.headPhoto placeholderImage:[UIImage   imageNamed:@"man"]];
    }
    
    [self.nameLabel setText:contractBean.name];
    [self.telPhoneLabel setText:contractBean.telphone];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
