//
//  FindPassword2ViewController.h
//  wyoa
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindPassword2ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nowPasswordText;
@property (weak, nonatomic) IBOutlet UITextField *againPasswordText;
@property (weak, nonatomic) IBOutlet UIButton *completeButton;
- (IBAction)completeClick:(id)sender;

@property(nonatomic,copy)NSString *authCode;
@property(nonatomic,copy)NSString *telphone;
@end
