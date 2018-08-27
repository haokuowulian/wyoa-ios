//
//  StaffDetailBean.h
//  wyoa
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoBean.h"
@interface StaffDetailBean : NSObject
@property(nonatomic,copy)NSString *CreateDate;
@property(nonatomic,copy)NSString *creator;
@property(nonatomic,copy)NSString *endDate;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *location;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *secition;
@property(nonatomic,copy)NSString *startDate;
@property(nonatomic,strong)UserInfoBean *userInfo;

@end
