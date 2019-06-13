//
//  NewWorkViewController.h
//  wyoa
//
//  Created by apple on 2018/10/27.
//  Copyright © 2018 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewWorkViewController : UIViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ChuQinMarginLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TongZhiMarginLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *GongChaiMarginLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TiaoBanMarginLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ChaoSongMarginLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ShenPiMarginLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ShenGouMarginLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *DingDanMarginLeft;

- (IBAction)daiwoshenpiClick:(id)sender;
- (IBAction)chuqinClick:(id)sender;

- (IBAction)shijiaClick:(id)sender;
- (IBAction)gongchaiClick:(id)sender;
- (IBAction)tiaobanClick:(id)sender;
- (IBAction)dingcanClick:(id)sender;

- (IBAction)faqiClick:(id)sender;
- (IBAction)chaosongClick:(id)sender;
- (IBAction)shenpiClick:(id)sender;
- (IBAction)lingyongClick:(id)sender;

- (IBAction)baoxiuClick:(id)sender;
- (IBAction)shengouClick:(id)sender;
- (IBAction)zhibanClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *daiwoshenpiNumButton;
@property (weak, nonatomic) IBOutlet UIButton *chuqinNumButton;
@end

NS_ASSUME_NONNULL_END
