//
//  WYDateTimePickerView.h
//  WYDatePickerViewDemo
//
//  Created by 意一yiyi on 2017/3/6.
//  Copyright © 2017年 意一yiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WYDateTimePickerViewBlock)(NSString *selectedDate);

@interface WYDateTimePickerView : UIView

@property (strong, nonatomic) WYDateTimePickerViewBlock confirmBlock;

- (instancetype)initWithInitialDate:(NSString *)initialDate;


@end
