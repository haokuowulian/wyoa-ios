//
//  UIColor+ColorChange.h
//  wjlx-new
//
//  Created by apple on 2018/7/6.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIColor (ColorChange)

// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *) colorWithHexString: (NSString *)color;
@end
