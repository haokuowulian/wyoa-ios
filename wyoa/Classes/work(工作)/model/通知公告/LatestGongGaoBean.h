//
//  LatestGongGaoBean.h
//  wyoa
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "BaseBean.h"
#import "LatestGongGaoDetailbean.h"
@interface LatestGongGaoBean : BaseBean
@property(nonatomic,copy)NSString *paths;
@property(nonatomic,strong)NSArray *names1;
@property(nonatomic,strong)LatestGongGaoDetailbean *newsSort;
@end
