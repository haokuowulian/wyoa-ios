//
//  NewsTableViewCell.h
//  wyoa
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsDetailBean.h"
@interface NewsTableViewCell : UITableViewCell
@property(nonatomic,strong)NewsDetailBean *newsDetailBean;
@property (weak, nonatomic) IBOutlet UILabel *creatorLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
