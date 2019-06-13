//
//  DingCanDetailBean.h
//  wyoa
//
//  Created by apple on 2018/8/28.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DingCanDetailBean : NSObject
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *coverImage;
@property(nonatomic,copy)NSString *foodName;
@property(nonatomic,copy)NSString *foodPrice;

@property(nonatomic,assign)NSInteger num;
@end
