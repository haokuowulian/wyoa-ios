//
//  DingDanDetailBean.h
//  wyoa
//
//  Created by apple on 2018/9/5.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DingDanDetailBean : NSObject
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *applicationTime; //下单时间
@property(nonatomic,copy)NSString *eatTime; //用餐时间;
@property(nonatomic,copy)NSString *content; //菜品内容
@property(nonatomic,copy)NSString *payMethod; //支付方式
@property(nonatomic,copy)NSString *realname; //下单人
@property(nonatomic,copy)NSString *telPhone; //电话
@property(nonatomic,strong)NSArray *dishes;
@end
