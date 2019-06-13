//
//  ShenPiRenQingBean.h
//  wyoa
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShenPiRenBean : NSObject
//抄送
@property(nonatomic,copy)NSString *chaoSongName;
@property(nonatomic,copy)NSString *chaoSongPic;
@property(nonatomic,copy)NSString *chaoSongSex;
//审批
@property(nonatomic,copy)NSString *oneLeveSex;
@property(nonatomic,copy)NSString *oneLevelN;
@property(nonatomic,copy)NSString *oneLevelP;
@property(nonatomic,copy)NSString *twoLeveSex;
@property(nonatomic,copy)NSString *twoLevelN;
@property(nonatomic,copy)NSString *twoLevelP;
@property(nonatomic,copy)NSString *threeLeveSex;
@property(nonatomic,copy)NSString *threeLevelN;
@property(nonatomic,copy)NSString *threeLevelP;
@end
