//
//  TongZhiGongGaoViewController.h
//  wyoa
//
//  Created by apple on 2018/8/14.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLTabedSlideView.h"
@interface TongZhiGongGaoViewController : UIViewController<DLTabedSlideViewDelegate>

@property (weak, nonatomic) IBOutlet DLTabedSlideView *tabedSlideView;

@end
