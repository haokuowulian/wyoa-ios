//
//  BaseView.h
//  wyoa
//
//  Created by apple on 2018/11/7.
//  Copyright © 2018 zjf. All rights reserved.
//

//
//  BaseView.h

#import <UIKit/UIKit.h>

#define kDatePicHeight 200  //选择器的高度
#define kTopViewHeight 44   //取消 标题 确定 行高度

#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface BaseView : UIView
// 背景蒙层视图
@property (nonatomic, strong) UIView *backgroundView;
// 弹出视图
@property (nonatomic, strong) UIView *alertView;
// 标题行顶部视图
@property (nonatomic, strong) UIView *topView;
// 左边取消按钮
@property (nonatomic, strong) UIButton *leftBtn;
// 右边确定按钮
@property (nonatomic, strong) UIButton *rightBtn;
// 中间标题
@property (nonatomic, strong) UILabel *titleLabel;
// 分割线视图
@property (nonatomic, strong) UIView *lineView;

/** 初始化子视图 ，整体布局*/
- (void)initUI;

//以下三种方法在基类中的实现都是空白的，具体的效果在子类中重写
/** 点击背景遮罩图层事件 */
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender;
/** 取消按钮的点击事件 */
- (void)clickLeftBtn;
/** 确定按钮的点击事件 */
- (void)clickRightBtn;

@end
