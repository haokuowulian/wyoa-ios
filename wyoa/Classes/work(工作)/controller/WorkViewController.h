//
//  WorkViewController.h
//  wyoa
//
//  Created by apple on 2018/8/13.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "BasicPanViewController.h"

@interface WorkViewController : BasicPanViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chuqinViewMarginLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *qingjiaViewMarginLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shenpiViewMarginLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *kaoqinViewMarginLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *guanliViewMarginLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shenqingViewMarginLeft;
@property (weak, nonatomic) IBOutlet UIButton *daiwoshenpiNumButton;
- (IBAction)daiwoshenpiClick:(id)sender;
- (IBAction)shenpiClick:(id)sender;

- (IBAction)orderClick:(id)sender;

- (IBAction)qingjiaClick:(id)sender;

@end
