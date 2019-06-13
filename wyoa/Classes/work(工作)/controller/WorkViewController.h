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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dingcanViewMarginLeft;

@property (weak, nonatomic) IBOutlet UIButton *daiwoshenpiNumButton;
@property (weak, nonatomic) IBOutlet UIButton *chuqinNumButton;

- (IBAction)chuqinClick:(id)sender;

- (IBAction)orderClick:(id)sender;

- (IBAction)qingjiaClick:(id)sender;
- (IBAction)dingdanManageClick:(id)sender;

@end
