//
//  ZJHKTabBarbutton.m
//  wjlx
//
//  Created by apple on 2018/7/11.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "ZJHKTabBarbutton.h"

@implementation ZJHKTabBarbutton

-(void)setHighlighted:(BOOL)highlighted{
    
}
 #pragma mark 设置Button内部的image的范围
 - (CGRect)imageRectForContentRect:(CGRect)contentRect
 {
        CGFloat imageW = 20;
         CGFloat imageH = 20;
   
         return CGRectMake(contentRect.size.width*0.5-10, 8.5, imageW, imageH);
     }

 #pragma mark 设置Button内部的title的范围
 - (CGRect)titleRectForContentRect:(CGRect)contentRect
{
//         CGFloat titleY =22;
         CGFloat titleW = contentRect.size.width;
        CGFloat titleH = 10;
    
         return CGRectMake(0, 34, titleW, titleH);
    }

@end
