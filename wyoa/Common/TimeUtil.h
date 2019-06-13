//
//  TimeUtil.h
//  wyoa
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeUtil : NSObject
+(NSString*)getCurrentTimesNOHour;
+(NSString*)getCurrentMonth;
+(NSString*)getNextMonth;
+(NSString *)getNMinute:(NSInteger)n;
+(NSString *)getNDay:(NSInteger)n;
+ (NSString *)MinutetransferToHourMin:(NSString *)minute;
+(NSString *)detailDayToSimpleTime:(NSString *)dayTime;
+(NSString *)detailDayToSimpleTime2:(NSString *)dayTime;
+(NSDate*)stringToDate:(NSString *)str;
+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(NSInteger)month;
@end
