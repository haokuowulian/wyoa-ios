//
//  FindPassword1ViewController.h
//  wyoa
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindPassword1ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;
- (IBAction)getCodeClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *telPhoneText;
@property (weak, nonatomic) IBOutlet UITextField *codeText;
- (IBAction)nextStepClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *errorCodeLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextStepButton;

@end
