//
//  MailListViewController.h
//  wyoa
//
//  Created by apple on 2018/8/13.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicPanViewController.h"
@interface MailListViewController : BasicPanViewController

@property (weak, nonatomic) IBOutlet UITextField *searchText;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
