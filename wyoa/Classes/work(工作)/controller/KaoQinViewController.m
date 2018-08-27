//
//  KaoQinViewController.m
//  wyoa
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "KaoQinViewController.h"
#import "MyKaoQinViewController.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import <MAMapKit/MAMapKit.h>
#import "JXTAlertManagerHeader.h"

@interface KaoQinViewController ()
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)AMapLocationManager *locationManager;
@property(nonatomic,copy)NSString *currentPosition;
@property (nonatomic, assign) CGFloat currentLatitude;
@property (nonatomic, assign) CGFloat currentLongitude;
@property(nonatomic,assign)NSInteger num;
@end

@implementation KaoQinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.num=0;
    [self getCurrentTime];
    //高德地图配置
    [self configLocationManager];
    
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.timer=nil;
    [self.locationManager stopUpdatingLocation];
    self.locationManager=nil;
}

- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    //设置允许连续定位逆地理
    [self.locationManager setLocatingWithReGeocode:YES];
    [self.locationManager startUpdatingLocation];

}
- (IBAction)lookMyKaoQingClick:(id)sender {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Mine" bundle:nil];
    MyKaoQinViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"kaoqin"];
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)dakaClick:(id)sender {
    //判断打卡范围
    if([self getDistance]<50){
        if(self.num==0){
             jxt_showAlertTitle(@"打卡成功");
            [self updateShangBanView];
            self.num++;
        }else if(self.num==1){
             jxt_showAlertTitle(@"打卡成功");
             [self updateXiaBanView];
             self.num++;
        }else{
           jxt_showAlertTitle(@"今日打卡已上限");
        }
    }else{
       jxt_showAlertTitle(@"打卡失败，未进入打卡范围");
    }
    
}

#pragma  mark 获取当前时间
-(void)getCurrentTime{
    self.timer =[NSTimer scheduledTimerWithTimeInterval:1.0f
                                             target:self
                                           selector:@selector(updateDatetime)
                                           userInfo:nil
                                            repeats:YES];
}

#pragma  mark 更新时间
-(void)updateDatetime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSDate *datenow = [NSDate date];
    NSString *nowtimeStr = [formatter stringFromDate:datenow];
    [self.buttonTimeLabel setText:nowtimeStr];

}

//接收位置更新,实现AMapLocationManagerDelegate代理的amapLocationManager:didUpdateLocation方法，处理位置更新

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    self.currentLatitude=location.coordinate.latitude;
    self.currentLongitude=location.coordinate.longitude;
//    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    if (reGeocode)
    {
        self.currentPosition=reGeocode.formattedAddress;
        [self.rangeLabel setText:self.currentPosition];
        NSLog(@"reGeocode:%@", reGeocode.formattedAddress);
        
    }
  
}

#pragma mark 计算两点距离（单位米）
-(double)getDistance{
    //1.将两个经纬度点转成投影点
    MAMapPoint point1 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(30.112217,120.185868));//湘湖科创园
    MAMapPoint point2 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(self.currentLatitude,self.currentLongitude));
    //2.计算距离
    CLLocationDistance distance = MAMetersBetweenMapPoints(point1,point2);
    return distance;
}

#pragma mark 初始化界面
-(void)initView{
    [self.shangbandakaStateImageView setImage:[UIImage imageNamed:@"xiabandaka1"]];//下班未打卡
    [self.shangbandakaTimeLabel setText:@"上班打卡"];
    [self.shangbanLocationView setHidden:YES];//未上班打卡状态下隐藏locationView
    
    [self.verticalView setHidden:YES];//未上班打卡状态下隐藏verticalView
    
    [self.xiabandakaStateImageView setHidden:YES];
    [self.xiabandakaTimeLabel setHidden:YES];
    [self.xiabanLocationView setHidden:YES];

}

#pragma mark 更新界面
-(void)updateShangBanView{
    [self.shangbandakaStateImageView setImage:[UIImage imageNamed:@"xiabandaka2"]];//上班已打卡
    [self.shangbandakaTimeLabel setText:[NSString stringWithFormat:@"%@%@",@"上班打卡时间:",self.buttonTimeLabel.text]];
    [self.shangbanLocationView setHidden:NO];//上班打卡成功后显示locationView
    [self.shangbanplaceLabel setText:self.currentPosition];
    
    [self.verticalView setHidden:NO];//上班打卡成功后显示verticalView
    
    [self.xiabandakaStateImageView setHidden:NO];
    [self.xiabandakaTimeLabel setHidden:NO];
    [self.xiabandakaStateImageView setImage:[UIImage imageNamed:@"xiabandaka1"]];//下班未打卡
    [self.xiabandakaTimeLabel setText:@"下班打卡"];
    [self.xiabanLocationView setHidden:YES];//未上班打卡状态下隐藏locationView
    
    [self.buttonTextLabel setText:@"下班打卡"];
    
}

#pragma mark 更新界面
-(void)updateXiaBanView{
   
    [self.xiabandakaStateImageView setImage:[UIImage imageNamed:@"xiabandaka2"]];//下班已打卡
    [self.xiabandakaTimeLabel setText:[NSString stringWithFormat:@"%@%@",@"下班打卡时间:",self.buttonTimeLabel.text]];
    [self.xiabanLocationView setHidden:NO];//下班打卡成功后显示locationView
    [self.xiabanplaceLabel setText:self.currentPosition];
    
     [self.buttonTextLabel setText:@"打卡完毕"];
    
}

@end
