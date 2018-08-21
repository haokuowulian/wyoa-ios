//
//  UpdateInfoViewController.h
//  wyoa
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoResultBean.h"
@interface UpdateInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *infoText;
@property (weak, nonatomic) IBOutlet UIButton *button;
- (IBAction)buttonClick:(id)sender;

@property(nonatomic,copy)NSString *text;
@property(nonatomic,copy)NSString *placeholder;

@property(nonatomic,strong)UserInfoResultBean *userInfoBean;
@end
