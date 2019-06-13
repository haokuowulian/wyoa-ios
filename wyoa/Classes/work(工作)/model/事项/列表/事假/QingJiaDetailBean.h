//
//  QingJiaDetailBean.h
//  wyoa
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoBean.h"
#import "UserInfoResultBean.h"
@interface QingJiaDetailBean : NSObject
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *realname;
@property(nonatomic,copy)NSString *startDate;
@property(nonatomic,copy)NSString *endDate;
@property(nonatomic,copy)NSString *appStatus;
@property(nonatomic,copy)NSString *fillformDate;
@property(nonatomic,copy)NSString *appState;

@property(nonatomic,strong)UserInfoResultBean *user;
@property(nonatomic,strong)UserInfoBean *userInfo;
@end
