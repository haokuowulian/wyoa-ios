//
//  GongChaiTableViewCell.h
//  wyoa
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GongChaiDetailBean.h"
@interface GongChaiTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@property(nonatomic,strong)GongChaiDetailBean *gongchaiDetailBean;
@end
