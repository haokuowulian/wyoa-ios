//
//  LingYongListBean.m
//  wyoa
//
//  Created by apple on 2018/8/28.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "LingYongListBean.h"

@implementation LingYongListBean
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"data" : @"LingYongDetailBean"};//前边，是属性数组的名字，后边就是类名
}
@end
