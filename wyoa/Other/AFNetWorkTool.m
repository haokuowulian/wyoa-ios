//
//  AFNetWorkTool.m
//  wjlx
//
//  Created by apple on 2018/7/16.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "AFNetWorkTool.h"

@implementation AFNetWorkTool


+(instancetype)shareInstance{
    static id instance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL=[NSURL URLWithString:@"http://18t69t8992.51mypc.cn:9079/oai/"];//本地
       
        NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
        //配置超时时长
        config.timeoutIntervalForRequest=15;
     
     
        instance=[[self alloc]initWithBaseURL:baseURL sessionConfiguration:config];
    });
    return instance;
}



@end
