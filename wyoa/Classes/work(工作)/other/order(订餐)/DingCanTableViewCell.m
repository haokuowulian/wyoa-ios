//
//  DingCanTableViewCell.m
//  wyoa
//
//  Created by apple on 2018/8/19.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "DingCanTableViewCell.h"

@implementation DingCanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.num=0;
    [self showOrHide];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)decreaseClick:(id)sender {
    if(self.num>0){
        self.num--;
    }
    [self showOrHide];
}

- (IBAction)increaseClick:(id)sender {
    self.num++;
    [self showOrHide];
   
}

-(void)showOrHide{
    [self.numLabel setText:[NSString stringWithFormat:@"%ld",self.num]];
    if(self.num==0){
        self.decreaseButton.hidden=YES;
        self.numLabel.hidden=YES;
    }else{
        self.decreaseButton.hidden=NO;
        self.numLabel.hidden=NO;
    }
}
@end
