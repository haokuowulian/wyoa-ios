//
//  ContractListBean.h
//  wyoa
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "BaseBean.h"

@interface ContractListBean : BaseBean
@property(nonatomic,copy)NSString *total;
@property(nonatomic,strong)NSArray *data;
@end
