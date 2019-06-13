//
//  CJYearMonthSelectedView.h
//  wyoa
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 zjf. All rights reserved.
//

//
//  CJYearMonthSelectedView.h

#import <UIKit/UIKit.h>
#import "BaseView.h"

//日期选择完成之后的操作
typedef void(^BRDateResultBlock)(NSString *selectValue);

@interface CJYearMonthSelectedView : BaseView

//对外开放的类方法
+ (void)showDatePickerWithTitle:(NSString *)title minDateStr:(NSString *)minDateStr resultBlock:(BRDateResultBlock)resultBlock;

@end
