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
+(NSString*)getCurrentMonth{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"yyyy-MM"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}


+(NSString*)getNextMonth{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"yyyy-MM"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    NSDate *nextDate=[self getPriousorLaterDateFromDate:datenow withMonth:1];
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:nextDate];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}
#pragma mark 获取n分钟前的日期
+(NSString *)getNMinute:(NSInteger)n{
    
    NSDate*nowDate = [NSDate date];
    
    NSDate* theDate;
    
    if(n!=0){
        
        NSTimeInterval  oneMinute = 60;  //1天的长度
        theDate = [nowDate initWithTimeIntervalSinceNow: oneMinute*n ];//initWithTimeIntervalSinceNow是从现在往前后推的秒数
        
    }else{
        
        theDate = nowDate;
    }
    
    NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
    [date_formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *the_date_str = [date_formatter stringFromDate:theDate];
    
    return the_date_str;
}
#pragma mark 获取n天前的日期
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

#pragma  mark 分钟转化为小时
+ (NSString *)MinutetransferToHourMin:(NSString *)minute {
 
    
    if (minute == nil || [minute isEqual:@""]) {
        
        return @"--";
        
    } else if ([minute intValue] >= 0 && [minute intValue] < 60) {
        
#pragma mark - *m
        
        NSString *time = [NSString stringWithFormat:@"%@分钟",minute];
        
        return time;
        
    } else if ([minute intValue] % 60 == 0 && [minute intValue] < 1440) {
        
#pragma mark - *h
        
        NSString *time = [NSString stringWithFormat:@"%d小时",[minute intValue] / 60];
        
        return time;
        
    } else if ([minute intValue] > 60 && [minute intValue] < 1440) {
        
#pragma mark -  *h*m
        
        NSInteger h = [minute intValue] / 60;
        
        NSInteger m = [minute intValue] - h * 60;
        
        NSString *time = [NSString stringWithFormat:@"%ld小时%ld分钟", (long)h,(long)m];
        
        return time;
        
    }else{
         return @"--";
    }
    
}

#pragma mark 年月日时分秒去除年月日
+(NSString *)detailDayToSimpleTime:(NSString *)dayTime{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *tempDate = [dateFormatter dateFromString:dayTime];
    NSDateFormatter *dateFormatter2= [[NSDateFormatter alloc] init];
       [dateFormatter2 setDateFormat:@"HH:mm:ss"];
    return [NSString stringWithFormat:@"%@",[dateFormatter2 stringFromDate:tempDate]];
}
#pragma mark 年月日时分秒去除时分秒
+(NSString *)detailDayToSimpleTime2:(NSString *)dayTime{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if([dayTime containsString:@"."]){
         [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.S"];
    }else{
         [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    NSDate *tempDate = [dateFormatter dateFromString:dayTime];
    NSDateFormatter *dateFormatter2= [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"yyyy-MM-dd"];
    return [NSString stringWithFormat:@"%@",[dateFormatter2 stringFromDate:tempDate]];
}

+(NSDate*)stringToDate:(NSString *)str{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];//解决8小时时间差问题
    return [dateFormatter dateFromString:str];
}


+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(NSInteger)month

{
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setMonth:month];
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    
    
    return mDate;
    
}
@end
