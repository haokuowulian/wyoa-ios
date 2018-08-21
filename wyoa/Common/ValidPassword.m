//
//  ValidPassword.m
//  wyoa
//
//  Created by apple on 2018/8/18.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "ValidPassword.h"

@implementation ValidPassword
+(BOOL)judgePassWordLegal:(NSString *)password{
    BOOL result = false;
    if ([password length] >= 8){
        // 判断长度大于8位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:password];
    }
    return result;
}
@end
