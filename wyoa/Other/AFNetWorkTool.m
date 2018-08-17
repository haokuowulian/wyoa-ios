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
        NSURL *baseURL=[NSURL URLWithString:@"http://192.168.1.92:9080/oai/oaCustom/"];//本地
       
        NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
        //配置超时时长
        config.timeoutIntervalForRequest=30;
     
     
        instance=[[self alloc]initWithBaseURL:baseURL sessionConfiguration:config];
    });
    return instance;
}



@end
