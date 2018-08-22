//
//  ContactModel.h
//  wyoa
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactBean : NSObject
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *name;
@property(nonatomic,copy)NSString *job;
@property(nonatomic,copy)NSString *secition;
@property(nonatomic,copy)NSString *telphone;
@property(nonatomic,copy)NSString *sex;
@property(nonatomic,copy)NSString *headPhoto;
@property(nonatomic,copy)NSString *mobilePhone;
@property(nonatomic,copy)NSString *sectionPhone;


// 搜索联系人的方法 (拼音/拼音首字母缩写/汉字)
+ (NSArray<ContactBean *> *)searchText:(NSString *)searchText inDataArray:(NSArray<ContactBean *> *)dataArray;
@end
