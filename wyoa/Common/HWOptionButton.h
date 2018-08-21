//
//  HWOptionButton.h
//  wyoa
//
//  Created by apple on 2018/8/18.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HWOptionButton;
@protocol HWOptionButtonDelegate <NSObject>

//确认选项后，如有其它特殊操作，用此代理事件
- (void)didSelectOptionInHWOptionButton:(HWOptionButton *)optionButton;

@end
@interface HWOptionButton : UIView

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign, readonly) NSInteger row;
@property (nonatomic, assign) BOOL showPlaceholder; //default is YES.
@property (nonatomic, assign) BOOL showSearchBar; //default is NO.
@property (nonatomic, weak) id<HWOptionButtonDelegate> delegate;


@end


