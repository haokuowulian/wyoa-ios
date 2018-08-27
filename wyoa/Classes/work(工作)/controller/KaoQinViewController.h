//
//  KaoQinViewController.h
//  wyoa
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KaoQinViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
- (IBAction)lookMyKaoQingClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *onTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *offTimeLabel;


@property (weak, nonatomic) IBOutlet UIImageView *shangbandakaStateImageView;
@property (weak, nonatomic) IBOutlet UILabel *shangbandakaTimeLabel;
@property (weak, nonatomic) IBOutlet UIView *shangbanLocationView;
@property (weak, nonatomic) IBOutlet UILabel *shangbanplaceLabel;

@property (weak, nonatomic) IBOutlet UIView *verticalView;

@property (weak, nonatomic) IBOutlet UIImageView *xiabandakaStateImageView;
@property (weak, nonatomic) IBOutlet UILabel *xiabandakaTimeLabel;
@property (weak, nonatomic) IBOutlet UIView *xiabanLocationView;
@property (weak, nonatomic) IBOutlet UILabel *xiabanplaceLabel;

@property (weak, nonatomic) IBOutlet UILabel *buttonTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *buttonTimeLabel;
- (IBAction)dakaClick:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *rangeLabel;

@end
