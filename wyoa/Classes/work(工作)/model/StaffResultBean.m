//
//  StaffResultBean.m
//  wyoa
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "StaffResultBean.h"

@implementation StaffResultBean
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"data" : @"StaffDetailBean"};//前边，是属性数组的名字，后边就是类名
}

@end
