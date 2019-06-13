//
//  CaiLanTableViewCell.h
//  wyoa
//
//  Created by apple on 2018/8/19.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMCheckBox.h"
#import "CaiLanDetailbean.h"
@interface CaiLanTableViewCell : UITableViewCell<BEMCheckBoxDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *foodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *eatTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodPricerLabel;
- (IBAction)deleteClick:(id)sender;
@property(nonatomic,assign)BOOL isChecked;

@property (weak, nonatomic) IBOutlet BEMCheckBox *checkBox;
@property(nonatomic,strong)CaiLanDetailbean *cailanDetailBean;

// 用typef宏定义来减少冗余代码
typedef void(^checkBoxClick)(BEMCheckBox * sender);// 这里的index是参数，我传递的是button的tag值，当然你可以自己决定传递什么参数
//下一步就是声明属性了，注意block的声明属性修饰要用copy
@property (nonatomic,copy) checkBoxClick checkAction;

// 用typef宏定义来减少冗余代码
typedef void(^deleteClick)(UIButton * sender);// 这里的index是参数，我传递的是button的tag值，当然你可以自己决定传递什么参数
//下一步就是声明属性了，注意block的声明属性修饰要用copy
@property (nonatomic,copy) deleteClick deleteAction;
@end
