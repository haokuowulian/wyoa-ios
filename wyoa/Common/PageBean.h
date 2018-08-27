//
//  PageBean.h
//  wyoa
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "BaseBean.h"

@interface PageBean : BaseBean
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,assign)NSInteger pageSize;
@property(nonatomic,assign)NSInteger count;
@property(nonatomic,copy)NSString *msg;
@end
