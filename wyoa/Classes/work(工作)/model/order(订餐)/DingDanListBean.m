//
//  DingDanListBean.m
//  wyoa
//
//  Created by apple on 2018/9/5.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "DingDanListBean.h"

@implementation DingDanListBean
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"data" : @"DingDanDetailBean"};//前边，是属性数组的名字，后边就是类名
}
@end
