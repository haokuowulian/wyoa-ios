//
//  ShenGouTableViewCell.h
//  wyoa
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShengGouDetailBean.h"
@interface ShenGouTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *applyDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *wupinLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property(nonatomic,strong)ShengGouDetailBean *shenggouDetailBean;
@end
