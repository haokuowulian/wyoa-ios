//
//  ChaoSongViewController.h
//  wyoa
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLTabedSlideView.h"
@interface ChaoSongViewController : UIViewController<DLTabedSlideViewDelegate>
@property (weak, nonatomic) IBOutlet DLTabedSlideView *tabedSlideView;

@end
