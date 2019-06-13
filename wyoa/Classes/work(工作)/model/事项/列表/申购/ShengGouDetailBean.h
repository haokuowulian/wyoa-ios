//
//  ShengGouDetailBean.h
//  wyoa
//
//  Created by apple on 2018/8/28.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoBean.h"
#import "UserInfoResultBean.h"

@interface ShengGouDetailBean : NSObject
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *appStatus;
@property(nonatomic,copy)NSString *fillformDate;
@property(nonatomic,copy)NSString *buyItems;
@property(nonatomic,copy)NSString *realname;
@property(nonatomic,copy)NSString *nowPhoto;
@property(nonatomic,copy)NSString *nowSex;

@property(nonatomic,strong)UserInfoResultBean *user;
@property(nonatomic,strong)UserInfoBean *userInfo;

@end
