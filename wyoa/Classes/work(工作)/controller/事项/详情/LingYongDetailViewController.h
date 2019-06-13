//
//  LingYongDetailViewController.h
//  wyoa
//
//  Created by apple on 2018/8/28.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LingYongDetailViewController : UIViewController
@property(nonatomic,copy)NSString *id;
@property(nonatomic,assign)BOOL needDeal;

@property (weak, nonatomic) IBOutlet UIImageView *FaQiRenHeadImageView;
@property (weak, nonatomic) IBOutlet UILabel *FaQiRenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *sectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobLabel;
@property (weak, nonatomic) IBOutlet UILabel *wupinNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *reasonLabel;
@property (weak, nonatomic) IBOutlet UILabel *refuseLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *refuseRightLabel;


@property (weak, nonatomic) IBOutlet UIView *shenpiView1;
@property (weak, nonatomic) IBOutlet UIImageView *shenpiImageView1;
@property (weak, nonatomic) IBOutlet UILabel *shenpiNameLabel1;
@property (weak, nonatomic) IBOutlet UIImageView *nextImageView1;

@property (weak, nonatomic) IBOutlet UIView *shenpiView2;
@property (weak, nonatomic) IBOutlet UIImageView *shenpiImageView2;
@property (weak, nonatomic) IBOutlet UILabel *shenpiNamelabel2;
@property (weak, nonatomic) IBOutlet UIImageView *nextImageView2;

@property (weak, nonatomic) IBOutlet UIView *shenpiView3;
@property (weak, nonatomic) IBOutlet UIImageView *shenpiImageView3;
@property (weak, nonatomic) IBOutlet UILabel *shenpiNamelabel3;


@property (weak, nonatomic) IBOutlet UIImageView *chaoSongImageView;
@property (weak, nonatomic) IBOutlet UILabel *chaoSongLabel;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
- (IBAction)refuseClick:(id)sender;
- (IBAction)agreenClick:(id)sender;
@end
