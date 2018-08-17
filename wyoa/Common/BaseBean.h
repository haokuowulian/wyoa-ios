//
//  BaseBean.h
//  wjlx
//
//  Created by apple on 2018/7/17.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseBean : NSObject
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,copy)NSString *message;

+(void)BeanByGetWithUrl:(NSString *)url Params:(NSDictionary *)parameters Success:(void(^)(NSDictionary *dict))success Error:(void(^)(NSError *err))error ;

+(void)BeanByPostWithUrl:(NSString *)url Params:(NSDictionary *)parameters Success:(void(^)(NSDictionary *dict))success Error:(void(^)(NSError *err))error ;



@end
