//
//  TiaoBanTableViewCell.h
//  wyoa
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiaoBanDetailBean.h"

@interface TiaoBanTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@property(nonatomic,strong)TiaoBanDetailBean *tiaobanDetailBean;

@end
