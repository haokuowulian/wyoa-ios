//
//  DingCanTableViewCell.h
//  wyoa
//
//  Created by apple on 2018/8/19.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DingCanDetailBean.h"
@interface DingCanTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
- (IBAction)addClick:(id)sender;

@property(nonatomic,strong)DingCanDetailBean *dingcanDetailBean;

// 用typef宏定义来减少冗余代码
typedef void(^ButtonClick)(UIButton * sender);
//下一步就是声明属性了，注意block的声明属性修饰要用copy
@property (nonatomic,copy) ButtonClick addAction;

@end
