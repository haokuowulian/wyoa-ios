//
//  KaoQinDetailBean.h
//  wyoa
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KaoQinDetailBean : NSObject
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *onDutyDate;//上班日期
@property(nonatomic,copy)NSString *minAttend;//出勤时长
@property(nonatomic,copy)NSString *clockOnTime; //上班打卡时间
@property(nonatomic,copy)NSString *onStatus; //上班状态
@property(nonatomic,copy)NSString *onTime; //上班时间
@property(nonatomic,copy)NSString *clockOffTime; //下班打卡时间
@property(nonatomic,copy)NSString *offStatus; //下班状态
@property(nonatomic,copy)NSString *offTime; //下班时间
@property(nonatomic,copy)NSString *minuteLate; //迟到时长（已有在状态为“迟到”时才有）
@property(nonatomic,copy)NSString *minLeave; //早退时长（已有在状态为“迟到”时才有）
@end
