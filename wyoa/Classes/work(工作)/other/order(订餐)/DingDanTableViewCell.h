//
//  DingDanTableViewCell.h
//  wyoa
//
//  Created by apple on 2018/9/5.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DingDanDetailBean.h"
@interface DingDanTableViewCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createDateLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *allPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *eatTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UILabel *payLabel;

@property(nonatomic,strong)DingDanDetailBean *dingdanDetailBean;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;

@end
