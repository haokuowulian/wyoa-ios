//
//  TimeUtil.m
//  wyoa
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "TimeUtil.h"

@implementation TimeUtil
#pragma  mark 获取当前时间(以秒为单位)
+(NSString*)getCurrentTimesNOHour{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

+(NSString *)getNDay:(NSInteger)n{
    
    NSDate*nowDate = [NSDate date];
    
    NSDate* theDate;
    
    if(n!=0){
        
        NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
        theDate = [nowDate initWithTimeIntervalSinceNow: oneDay*n ];//initWithTimeIntervalSinceNow是从现在往前后推的秒数
        
    }else{
        
        theDate = nowDate;
    }
    
    NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
    [date_formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *the_date_str = [date_formatter stringFromDate:theDate];
    
    return the_date_str;
}


@end
