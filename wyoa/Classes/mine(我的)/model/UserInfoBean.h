//
//  UserInfoBean.h
//  wyoa
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoBean : NSObject
@property(nonatomic,assign)NSInteger chatMsgCount;
@property(nonatomic,copy)NSString *headPhoto;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *job;
@property(nonatomic,copy)NSString *orgId;
@property(nonatomic,copy)NSString *realName;
@property(nonatomic,copy)NSString *secition;
@property(nonatomic,copy)NSString *userId;
@end
