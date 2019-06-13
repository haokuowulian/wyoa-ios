//
//  TiaoBanDetailBean.h
//  wyoa
//
//  Created by apple on 2018/8/28.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoBean.h"
#import "UserInfoResultBean.h"

@interface TiaoBanDetailBean : NSObject
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *oldWorkDate;
@property(nonatomic,copy)NSString *nowWorkDate;
@property(nonatomic,copy)NSString *incident;
@property(nonatomic,copy)NSString *createDate;
@property(nonatomic,copy)NSString *state;
@property(nonatomic,copy)NSString *realname;
@property(nonatomic,copy)NSString *transferSex;
@property(nonatomic,copy)NSString *nowPhoto;
@property(nonatomic,copy)NSString *appStatus;

@property(nonatomic,strong)UserInfoResultBean *user;
@property(nonatomic,strong)UserInfoBean *userInfo;
@end
