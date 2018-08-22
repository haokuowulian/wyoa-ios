//
//  ContactDetailViewController.h
//  wyoa
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactBean.h"

@interface ContactDetailViewController : UIViewController
@property(nonatomic,strong)ContactBean *userInfoBean;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *realNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *telphoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobilePhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *sectionPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *userJobLabel;
@property (weak, nonatomic) IBOutlet UILabel *sectionLabel;

- (IBAction)messageClick:(id)sender;
- (IBAction)telphoneClick:(id)sender;
- (IBAction)mobilePhoneClick:(id)sender;
- (IBAction)sectionPhoneClick:(id)sender;

@end
