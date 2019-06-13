//
//  ApproveBean.m
//  wyoa
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "ApproveBean.h"

@implementation ApproveBean
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"chaoSongSex": @"copySex",
             @"chaoSongName":@"copylN",
             @"chaoSongPic":@"copylP",
             @"nowWorkDate":@"newWorkDate"
             };
}
@end
