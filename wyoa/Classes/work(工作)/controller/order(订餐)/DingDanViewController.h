//
//  DingDanViewController.h
//  wyoa
//
//  Created by apple on 2018/8/19.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DingDanViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *startTimeText;
@property (weak, nonatomic) IBOutlet UITextField *endTimeText;

- (IBAction)startTimeClick:(id)sender;
- (IBAction)endTimeClick:(id)sender;

@end
