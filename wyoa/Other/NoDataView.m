//
//  NoDataView.m
//  wyoa
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "NoDataView.h"
NSString * const kNoDataViewObserveKeyPath = @"frame";
@implementation NoDataView

- (void)dealloc {
    NSLog(@"占位视图正常销毁");
}

@end
