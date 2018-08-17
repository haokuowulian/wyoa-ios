//
//  BaseBean.m
//  wjlx
//
//  Created by apple on 2018/7/17.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "BaseBean.h"
#import "AFNetWorkTool.h"

@implementation BaseBean
+(void)BeanByGetWithUrl:(NSString *)url Params:(NSDictionary *)parameters Success:(void(^)(NSDictionary *dict))success Error:(void(^)(NSError *err))error {
   
    [[AFNetWorkTool shareInstance]GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success){
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull er) {
        if(error){
            error(er);
        }
    }];
};
+(void)BeanByPostWithUrl:(NSString *)url Params:(NSDictionary *)parameters Success:(void (^)(NSDictionary *))success Error:(void (^)(NSError *))error{
    AFNetWorkTool *tool=[AFNetWorkTool shareInstance];
    tool.requestSerializer=[AFJSONRequestSerializer serializer];
    [tool POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success){
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull er) {
        if(error){
            error(er);
        }
    }];
}



@end
