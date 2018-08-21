//
//  UserInfoResultBean.h
//  wyoa
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 zjf. All rights reserved.
//

//"success": true,
//"userName": "姚春钢",
//"realname": "姚春钢",
//"sex": "女",
//"birthday": "2018-08-01",
//"telPhone": "13575710777",
//"address": "",
//"qq": "902058",
//"userType": 1,
//"userTypeName": "工作人员",
//"userJob": "中心副书记",
//"userSecition": "党务、行政后勤",
//"mobilePhone": "902058",
//"sectionPhone": "904536",
//"headPhoto": "http://192.168.1.92:9080/oa//upload/photo/2018-08/20180803142624_447.PNG"

#import "BaseBean.h"

@interface UserInfoResultBean : BaseBean
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *userName;
@property(nonatomic,copy)NSString *realname;
@property(nonatomic,copy)NSString *sex;
@property(nonatomic,copy)NSString *birthday;
@property(nonatomic,copy)NSString *telPhone;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *qq;
@property(nonatomic,copy)NSString *weChat;
@property(nonatomic,copy)NSString *userType;
@property(nonatomic,copy)NSString *userTypeName;
@property(nonatomic,copy)NSString *userJob;
@property(nonatomic,copy)NSString *userSecition;
@property(nonatomic,copy)NSString *headPhoto;
@property(nonatomic,copy)NSString *mobilePhone;
@property(nonatomic,copy)NSString *sectionPhone;
@end
