//
//  ApproveBean.h
//  wyoa
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShenPiRenBean.h"
#import "UserInfoBean.h"
#import "UserInfoResultBean.h"
@interface ApproveBean : ShenPiRenBean
@property(nonatomic,copy)NSString *appStatus;
@property(nonatomic,copy)NSString *startDate;
@property(nonatomic,copy)NSString *endDate;
@property(nonatomic,copy)NSString *howlong;
@property(nonatomic,copy)NSString *incident;
@property(nonatomic,copy)NSString *leaveType;
@property(nonatomic,copy)NSString *refusefor;
@property(nonatomic,strong)UserInfoBean *userInfo;
@property(nonatomic,strong)UserInfoResultBean *user;

//调班所用字段
@property(nonatomic,copy)NSString *nowWorkDate;
@property(nonatomic,copy)NSString *nowPhoto;
@property(nonatomic,copy)NSString *nowSex;
@property(nonatomic,copy)NSString *oldWorkDate;
@property(nonatomic,copy)NSString *state;
@property(nonatomic,copy)NSString *userName;
@property(nonatomic,copy)NSString *transferJob;
@property(nonatomic,copy)NSString *transferSection;
@property(nonatomic,copy)NSString *transferName;

//申购所用字段
@property(nonatomic,copy)NSString *buyItems;
@property(nonatomic,copy)NSString *job;
@property(nonatomic,copy)NSString *realname;
@property(nonatomic,copy)NSString *fillformDate;
@property(nonatomic,copy)NSString *section;

//报修所用字段
@property(nonatomic,copy)NSString *damage;
@property(nonatomic,copy)NSString *expectfixDate;
@property(nonatomic,copy)NSString *fixAddress;
@property(nonatomic,copy)NSString *fixItems;

//领用多用字段
@property(nonatomic,copy)NSString *items_name;
@property(nonatomic,copy)NSString *appState;
@end
