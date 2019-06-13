//
//  DingDanTableViewCell.m
//  wyoa
//
//  Created by apple on 2018/9/5.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "DingDanTableViewCell.h"
#import "DingCanDetailBean.h"
#import "CaiPinTableViewCell.h"
#import "MJExtension.h"
@implementation DingDanTableViewCell
-(void)setDingdanDetailBean:(DingDanDetailBean *)dingdanDetailBean{
    _dingdanDetailBean=dingdanDetailBean;
    [self.nameLabel setText: [NSString stringWithFormat:@"%@的订单",dingdanDetailBean.realname]];
    [self.createDateLabel setText:dingdanDetailBean.applicationTime];
    [self.eatTimeLabel setText:dingdanDetailBean.eatTime];
    [self.telLabel setText:dingdanDetailBean.telPhone];
    [self.payLabel setText:dingdanDetailBean.payMethod];
    NSDecimalNumber *total=[NSDecimalNumber decimalNumberWithString:@"0"];
    for(int i=0;i<dingdanDetailBean.dishes.count;i++){
        DingCanDetailBean *bean=dingdanDetailBean.dishes[i];
        NSDecimalNumber *danjia=[NSDecimalNumber decimalNumberWithString:bean.foodPrice];
         NSDecimalNumber *shuliang=[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%ld",bean.num]];
        NSDecimalNumber *result = [danjia decimalNumberByMultiplyingBy:shuliang];
         total=[total decimalNumberByAdding:result];
        
    }
    [self.allPriceLabel setText:[NSString stringWithFormat:@"￥%@",total]];
    
   self.tableViewHeight.constant=self.dingdanDetailBean.dishes.count*32;
    [self.tableView reloadData];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self.tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:v];
    [self.tableView registerNib:[UINib nibWithNibName:@"CaiPinTableViewCell" bundle:nil] forCellReuseIdentifier:@"cai"];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;//这里间距为10，可以根据自己的情况调整
//    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 2 * frame.origin.x;
    [super setFrame:frame];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dingdanDetailBean.dishes.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cai";
    // 1.缓存中取
    CaiPinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[CaiPinTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSArray *tempArray=[DingCanDetailBean mj_objectArrayWithKeyValuesArray:self.dingdanDetailBean.dishes];
    
    DingCanDetailBean *bean=tempArray[indexPath.row];
    cell.dingcanDetailBean=bean;
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //跳转到详情
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 32;
}

@end
