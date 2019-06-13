//
//  MyKaoQinViewController.m
//  wyoa
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "MyKaoQinViewController.h"
#import "TimeUtil.h"
#import "TZDatePickerView.h"
#import "KaoQinTableViewCell.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "MyKaoQinResultBean.h"
#import "KaoQinDetailBean.h"
#import "Extern.h"
#import "MBProgressHUD+MBProgressHUD.h"

@interface MyKaoQinViewController ()
@property(nonatomic,copy)NSString *startTime;
@property(nonatomic,copy)NSString *endTime;
@property (nonatomic, strong) TZDatePickerView *datePicker; // 日期选择器
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,strong)NSMutableArray *kaoqinArray;
@end

@implementation MyKaoQinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.startTime=[TimeUtil getNDay:-30];
    self.endTime=[TimeUtil getCurrentTimesNOHour];
   
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:v];
     [self.tableView registerNib:[UINib nibWithNibName:@"KaoQinTableViewCell" bundle:nil] forCellReuseIdentifier:@"kaoqin"];
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        self.pageIndex=0;
        [self getKaoQin];
      
        
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        self.pageIndex++;
        [self getKaoQin];
        
    }];
    
      self.pageIndex=0;
   
    [MBProgressHUD showMessage:@"正在获取考勤数据..."];
    [self setTitleButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!_datePicker) self.datePicker = [[TZDatePickerView alloc] init];
}
/** 一定要记得在这里移除，因为是加在window上的，否则会造成内存泄露  */
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_datePicker) [self.datePicker removeFromSuperview];
}

#pragma mark 设置navigation title
-(void)setTitleButton{
    NSString *titleText=[NSString stringWithFormat:@"%@~%@",self.startTime,self.endTime];
    UIButton *button= [[UIButton alloc] init];
    [button setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    [button setTitle:titleText forState:UIControlStateNormal];
    //    [button setBackgroundColor:[UIColor redColor]];
    [button addTarget:self action:@selector(selectDate) forControlEvents:UIControlEventTouchUpInside];
    UIImage *image =button.imageView.image;
    UILabel *titleLabel =button.titleLabel;
    titleLabel.font=[UIFont systemFontOfSize:16.0f];
    titleLabel.center=button.center;
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width, 0, image.size.width)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, titleLabel.bounds.size.width+180, 0, -titleLabel.bounds.size.width)];
    [button addTarget:self action:@selector(selectDate) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView =button;
    [self getKaoQin];
}
#pragma mark 选择日期段
-(void)selectDate{
    [self.datePicker show];
    __weak typeof(self) weakSelf = self;
    self.datePicker.gotoSrceenOrderBlock = ^(NSString *beginDateStr,NSString *endDateStr){
        [weakSelf.datePicker hide];
        weakSelf.startTime=beginDateStr;
        weakSelf.endTime=endDateStr;
        [weakSelf setTitleButton];
    };
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.kaoqinArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"kaoqin";
    // 1.缓存中取
    KaoQinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[KaoQinTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.kaoqinDetailBean=self.kaoqinArray[indexPath.row];
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //跳转到详情
      [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 191.5f;
}

#pragma mark 获取我的考勤数据
-(void)getKaoQin{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *userId=[userDefault objectForKey:@"userId"];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"oaCustom/getMyAttendanceList.do",apikey];
    NSDictionary *params=@{@"pageIndex":[NSString stringWithFormat:@"%ld",self.pageIndex],
                           @"pageSize":@"10",
                           @"userId":userId,
                           @"startTime":self.startTime,
                           @"endTime":self.endTime
                           };
    [MyKaoQinResultBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
        [MBProgressHUD hideHUD];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
         MyKaoQinResultBean *myKaoQinResultBean=[MyKaoQinResultBean mj_objectWithKeyValues:dict];
        if(myKaoQinResultBean.success==1){
            NSMutableArray *tempArray=[KaoQinDetailBean mj_objectArrayWithKeyValuesArray:myKaoQinResultBean.data];
            if(self.pageIndex==0){
                self.kaoqinArray=tempArray;
            }else{
                [self.kaoqinArray addObjectsFromArray:tempArray];
            }
            if(self.kaoqinArray.count==myKaoQinResultBean.count){
                self.tableView.mj_footer.hidden=YES;
            }else{
                self.tableView.mj_footer.hidden=NO;
            }
            [self.tableView reloadData];
        }else{
             [MBProgressHUD hideHUD];
             [MBProgressHUD showError:myKaoQinResultBean.message];
        }
    } Error:^(NSError *err) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
         [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"网络连接失败"];
    }];
}


#pragma mark - TableView 占位图

- (UIImage *)nodata_noDataViewImage {
    self.tableView.mj_footer.hidden=YES;
    return [UIImage imageNamed:@"neirong"];
}

- (NSString *)nodata_noDataViewMessage {
    return @"还没有内容哦";
}

- (UIColor *)nodata_noDataViewMessageColor {
    return [UIColor colorWithHexString:@"999999"];
}
@end
