//
//  MyKaoQinResultBean.h
//  wyoa
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KaoQinDetailBean.h"
@interface MyKaoQinResultBean : NSObject
@property(nonatomic,assign)Boolean success;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,assign)NSInteger pageSize;
@property(nonatomic,assign)NSInteger count;
@property(nonatomic,strong)NSArray *data;

+(void)BeanByPostWithUrl:(NSString *)url Params:(NSDictionary *)parameters Success:(void(^)(NSDictionary *dict))success Error:(void(^)(NSError *err))error ;

@end
