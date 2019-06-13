//
//  TalkViewController.h
//  wyoa
//
//  Created by apple on 2018/9/12.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface TalkViewController : UIViewController<WKNavigationDelegate,WKUIDelegate,UIScrollViewDelegate>
@property(nonatomic,copy)NSString *chatUrl;
@property(nonatomic,copy)NSString *name;
@end
