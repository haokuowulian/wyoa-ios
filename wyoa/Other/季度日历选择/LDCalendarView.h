//
//  LDCalendarView.h
//
//  Created by lidi on 15/9/1.
//  Copyright (c) 2015年 lidi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDCalendarConst.h"

typedef void(^DaysSelectedBlock)(NSArray *result,UITextField *textField);

@interface LDCalendarView : UIView
@property (nonatomic, strong) NSArray          *defaultDays;
@property (nonatomic, copy  ) DaysSelectedBlock complete;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)NSMutableArray *array;
- (id)initWithFrame:(CGRect)frame;
- (void)show:(UITextField *)textField ;
- (void)hide;

@end
