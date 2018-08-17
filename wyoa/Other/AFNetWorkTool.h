//
//  AFNetWorkTool.h
//  wjlx
//
//  Created by apple on 2018/7/16.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface AFNetWorkTool : AFHTTPSessionManager
+(instancetype)shareInstance;
typedef void (^WDHttpProgress)(NSProgress *progress);
/// 请求成功的Block
typedef void(^WDHttpRequestSuccess)(id responseObject);
/// 请求失败的Block
typedef void(^WDHttpRequestFailed)(NSError *error);


@end
