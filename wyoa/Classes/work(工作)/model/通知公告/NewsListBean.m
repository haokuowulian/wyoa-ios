//
//  NewsListBean.m
//  wyoa
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "NewsListBean.h"

@implementation NewsListBean
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"data" : @"NewsDetailBean"};//前边，是属性数组的名字，后边就是类名
}
@end
