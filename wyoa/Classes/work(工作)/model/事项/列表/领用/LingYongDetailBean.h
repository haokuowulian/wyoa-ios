//
//  LingYongDetailBean.h
//  wyoa
//
//  Created by apple on 2018/8/28.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoBean.h"
#import "UserInfoResultBean.h"

@interface LingYongDetailBean : NSObject
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *appState;
@property(nonatomic,copy)NSString *realname;
@property(nonatomic,copy)NSString *fillformDate;
@property(nonatomic,copy)NSString *incident;//物品用途
@property(nonatomic,copy)NSString *items_name;//物品名称

@property(nonatomic,strong)UserInfoResultBean *user;
@property(nonatomic,strong)UserInfoBean *userInfo;

@end
