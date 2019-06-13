//
//  BaoXiuTableViewCell.h
//  wyoa
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaoXiuDetailBean.h"
@interface BaoXiuTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *expectDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *wupinLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *createDateLabel;

@property(nonatomic,strong)BaoXiuDetailBean *baoxiuDetailBean;
@end
