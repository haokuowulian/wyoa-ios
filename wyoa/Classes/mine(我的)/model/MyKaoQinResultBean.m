//
//  MyKaoQinResultBean.m
//  wyoa
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "MyKaoQinResultBean.h"
#import "AFNetWorkTool.h"

@implementation MyKaoQinResultBean
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"data" : @"KaoQinDetailBean"};//前边，是属性数组的名字，后边就是类名
}

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
