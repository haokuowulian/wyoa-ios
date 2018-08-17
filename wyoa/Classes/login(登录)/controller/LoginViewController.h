//
//  LoginViewController.h
//  wyoa
//
//  Created by apple on 2018/8/13.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UINavigationControllerDelegate>
- (IBAction)loginClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@end
