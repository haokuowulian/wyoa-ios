//
//  QIngJiaShenPiRenBean.h
//  wyoa
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "BaseBean.h"

@interface QIngJiaShenPiRenBean : BaseBean
//审批人信息
@property(nonatomic,copy)NSString *oneLevelId;
@property(nonatomic,copy)NSString *twoLevelId;
@property(nonatomic,copy)NSString *threeLevelId;
@property(nonatomic,copy)NSString *oneLevelN;
@property(nonatomic,copy)NSString *twoLevelN;
@property(nonatomic,copy)NSString *threeLevelN;
@property(nonatomic,copy)NSString *oneLevelP;
@property(nonatomic,copy)NSString *twoLevelP;
@property(nonatomic,copy)NSString *threeLevelP;
@property(nonatomic,copy)NSString *oneLeveSex;
@property(nonatomic,copy)NSString *twoLeveSex;
@property(nonatomic,copy)NSString *threeLeveSex;
//抄送人信息
@property(nonatomic,copy)NSString *CourtesyCopyId;
@property(nonatomic,copy)NSString *CourtesyCopylN;
@property(nonatomic,copy)NSString *CourtesyCopylP;
@property(nonatomic,copy)NSString *CourtesyCopySex;
@end
