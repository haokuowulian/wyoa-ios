//
//  ShengGouChaoSongViewController.h
//  wyoa
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShengGouChaoSongViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,copy)NSString *fillformDate;
@end
