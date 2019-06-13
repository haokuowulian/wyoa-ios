//
//  GongChaiDetailBean.h
//  wyoa
//
//  Created by apple on 2018/8/28.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoBean.h"
#import "UserInfoResultBean.h"

@interface GongChaiDetailBean : NSObject
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *appStatus;//审核状态
@property(nonatomic,copy)NSString *realname;//谁的公差
@property(nonatomic,copy)NSString *startDate;//开始时间
@property(nonatomic,copy)NSString *endDate;//结束时间
@property(nonatomic,copy)NSString *fillformDate;//填表时间
@property(nonatomic,copy)NSString *appState;//填表时间s

@property(nonatomic,strong)UserInfoResultBean *user;
@property(nonatomic,strong)UserInfoBean *userInfo;
@end
