//
//  MeetingTongZhiBean.h
//  wyoa
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "BaseBean.h"
#import "MeetingTongZhiDetailBean.h"
@interface MeetingTongZhiBean : BaseBean
@property(nonatomic,copy)NSString *paths;
@property(nonatomic,strong)NSArray *names;
@property(nonatomic,strong)MeetingTongZhiDetailBean *conference;
@end
