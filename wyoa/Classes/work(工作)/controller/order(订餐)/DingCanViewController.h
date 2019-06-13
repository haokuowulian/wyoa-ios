//
//  DingCanViewController.h
//  wyoa
//
//  Created by apple on 2018/8/19.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DingCanViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *zaocanTableView;
@property (weak, nonatomic) IBOutlet UITableView *wucanTableView;
@property (weak, nonatomic) IBOutlet UITableView *wancanTableView;

- (IBAction)segmentChange:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;



@end
