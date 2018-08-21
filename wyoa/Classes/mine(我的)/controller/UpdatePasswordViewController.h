//
//  UpdatePasswordViewController.h
//  wyoa
//
//  Created by apple on 2018/8/18.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdatePasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordText;
@property (weak, nonatomic) IBOutlet UITextField *nowPasswordText;
@property (weak, nonatomic) IBOutlet UITextField *againPasswordText;

@end
