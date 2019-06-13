//
//  QingJiaTableViewCell.h
//  wyoa
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QingJiaDetailBean.h"
@interface QingJiaTableViewCell : UITableViewCell

@property(nonatomic,strong)QingJiaDetailBean *qingjiaDetailBean;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@end
