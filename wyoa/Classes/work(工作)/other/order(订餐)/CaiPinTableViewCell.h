//
//  CaiPinTableViewCell.h
//  wyoa
//
//  Created by apple on 2018/9/5.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DingCanDetailBean.h"

@interface CaiPinTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *caiNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property(nonatomic,strong)DingCanDetailBean *dingcanDetailBean;
@end
