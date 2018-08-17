//
//  LoginResultBean.h
//  wyoa
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "BaseBean.h"

@interface LoginResultBean : BaseBean
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *userName;
@property(nonatomic,copy)NSString *apikey;
@end
