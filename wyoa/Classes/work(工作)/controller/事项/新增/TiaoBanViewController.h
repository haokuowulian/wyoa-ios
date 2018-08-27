//
//  TiaoBanViewController.h
//  wyoa
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQKeyboardManager.h"
@interface TiaoBanViewController : UIViewController
- (IBAction)huanbanrenClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *huanbanrenText;
- (IBAction)orginTimeClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *orginTimeText;
- (IBAction)tiaobanTimeClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *tiaobanTimeText;
@property (weak, nonatomic) IBOutlet IQTextView *reasonText;


@property (weak, nonatomic) IBOutlet UIView *shenpiView1;
@property (weak, nonatomic) IBOutlet UIImageView *shenpiImageView1;
@property (weak, nonatomic) IBOutlet UILabel *shenpiNameLabel1;
@property (weak, nonatomic) IBOutlet UIImageView *nextImageView1;

@property (weak, nonatomic) IBOutlet UIView *shenpiView2;
@property (weak, nonatomic) IBOutlet UIImageView *shenpiImageView2;
@property (weak, nonatomic) IBOutlet UILabel *shenpiNamelabel2;
@property (weak, nonatomic) IBOutlet UIImageView *nextImageView2;

@property (weak, nonatomic) IBOutlet UIView *shenpiView3;
@property (weak, nonatomic) IBOutlet UIImageView *shenpiImageView3;
@property (weak, nonatomic) IBOutlet UILabel *shenpiNamelabel3;


@property (weak, nonatomic) IBOutlet UIImageView *chaoSongImageView;
@property (weak, nonatomic) IBOutlet UILabel *chaoSongLabel;
- (IBAction)addChaoSongRen:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *submitButton;
- (IBAction)submitClick:(id)sender;

@end
