//
//  OrderManageViewController.h
//  wyoa
//
//  Created by apple on 2018/9/5.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderManageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *searchView;
@property (weak, nonatomic) IBOutlet UITextField *startTimeText;
@property (weak, nonatomic) IBOutlet UITextField *endTimeText;

- (IBAction)startTimeClick:(id)sender;
- (IBAction)endTimeClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
