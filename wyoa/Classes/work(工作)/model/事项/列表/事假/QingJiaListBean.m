//
//  QingJiaListBean.m
//  wyoa
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "QingJiaListBean.h"

@implementation QingJiaListBean
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"data" : @"QingJiaDetailBean"};//前边，是属性数组的名字，后边就是类名
}
@end
