//
//  CaiLanListBean.m
//  wyoa
//
//  Created by apple on 2018/9/2.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "CaiLanListBean.h"

@implementation CaiLanListBean
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"data" : @"CaiLanDetailBean"};//前边，是属性数组的名字，后边就是类名
}
@end
