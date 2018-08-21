//
//  PersonalInfoViewController.h
//  wyoa
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 zjf. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "UserInfoResultBean.h"

@interface PersonalInfoViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *realNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobilePhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *telPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *qqLabel;
@property (weak, nonatomic) IBOutlet UILabel *wxLabel;
@property (weak, nonatomic) IBOutlet UILabel *sectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *sectionTelLabel;
@property (weak, nonatomic) IBOutlet UILabel *userJobLbel;
- (IBAction)userNameClick:(id)sender;
- (IBAction)sectionClick:(id)sender;
- (IBAction)sectionTelClick:(id)sender;
- (IBAction)userjobClick:(id)sender;


- (IBAction)headViewClick:(id)sender;

@property(nonatomic,strong)UserInfoResultBean *userInfoBean;

@end
