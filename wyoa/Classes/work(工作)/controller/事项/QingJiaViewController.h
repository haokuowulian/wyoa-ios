//
//  QingJiaViewController.h
//  wyoa
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
@interface QingJiaViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *typeText;
- (IBAction)typeClick:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *startTimeText;
- (IBAction)startTimeClick:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *endTimeText;
- (IBAction)endTimeClick:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *howLongText;

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
