//
//  UIImage+HK.m
//  wyoa
//
//  Created by apple on 2018/8/24.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "UIImage+HK.h"

@implementation UIImage (HK)
+ (UIImage *)createImageWithColor:(UIColor*) color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
