//
//  OrderManageViewController.m
//  wyoa
//
//  Created by apple on 2018/9/5.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "OrderManageViewController.h"
#import "WYBirthdayPickerView.h"
#import "DingDanListBean.h"
#import "DingDanDetailBean.h"
#import "Extern.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "MBProgressHUD+MBProgressHUD.h"
#import "DingDanTableViewCell.h"

@interface OrderManageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,strong)NSMutableArray *dingdanArray;
@property(nonatomic,copy)NSString *realname;
@end

@implementation OrderManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.realname=@"";
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:v];
    [self.tableView registerNib:[UINib nibWithNibName:@"DingDanTableViewCell" bundle:nil] forCellReuseIdentifier:@"dingdan"];
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        self.pageIndex=0;
        [self getOrderList];
        
        
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        self.pageIndex++;
        [self getOrderList];
        
    }];
    
    self.pageIndex=0;
    [self getOrderList];
     [self.searchView addTarget:self action:@selector(passConTextChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    UILabel *label=[[UILabel alloc]init];
    label.text=@"订单";
    label.textColor=[UIColor colorWithHexString:@"333333"];;
    label.font=[UIFont systemFontOfSize:20.0f];
    self.tabBarController.navigationItem.titleView=label;
    
    //    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithTitle:@"金额汇总" style:(UIBarButtonItemStyleDone) target:self action:@selector(summury)];
    //    self.tabBarController.navigationItem.rightBarButtonItem = rightitem;
    //    [self.tabBarController.navigationItem.rightBarButtonItem setTintColor:kThemeColor];
}


- (IBAction)startTimeClick:(id)sender {
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    dateFormatter.dateFormat=@"yyyy-MM-dd";
    WYBirthdayPickerView *datePickerView = [[WYBirthdayPickerView alloc] initWithInitialDate:[dateFormatter stringFromDate:[NSDate date]] andDateFormatter:@"yyyy-MM-dd"];
    // 选择日期完成之后的回调 : 按自己的要求做相应的处理就可以了
    datePickerView.confirmBlock = ^(NSString *selectedDate) {
        self.startTimeText.text=selectedDate;
        if(self.endTimeText.text.length>0){
            self.pageIndex=0;
            [self getOrderList];
        }
        
    };
    
    [self.view addSubview:datePickerView];
}

- (IBAction)endTimeClick:(id)sender {
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    dateFormatter.dateFormat=@"yyyy-MM-dd";
    WYBirthdayPickerView *datePickerView = [[WYBirthdayPickerView alloc] initWithInitialDate:[dateFormatter stringFromDate:[NSDate date]]andDateFormatter:@"yyyy-MM-dd"];
    // 选择日期完成之后的回调 : 按自己的要求做相应的处理就可以了
    datePickerView.confirmBlock = ^(NSString *selectedDate) {
        self.endTimeText.text=selectedDate;
        if(self.startTimeText.text.length>0){
            self.pageIndex=0;
            [self getOrderList];
        }
    };
    
    [self.view addSubview:datePickerView];
}

#pragma mark 获取订单列表
-(void)getOrderList{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    NSString *userId=[userDefault objectForKey:@"userId"];
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"mess/getInOrderManageList.do",apikey];
    NSDictionary *params=@{@"userId":userId,
                           @"pageIndex":[NSString stringWithFormat:@"%ld",self.pageIndex],
                           @"pageSize":@"10",
                           @"startTime":self.startTimeText.text,
                           @"endTime":self.endTimeText.text,
                           @"realname":self.realname
                           };
    [DingDanListBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        DingDanListBean *dingdanListBean=[DingDanListBean mj_objectWithKeyValues:dict];
        if(dingdanListBean.success==1){
            NSMutableArray *tempArray=[DingDanDetailBean mj_objectArrayWithKeyValuesArray:dingdanListBean.data];
            if(self.pageIndex==0){
                self.dingdanArray=tempArray;
            }else{
                [self.dingdanArray addObjectsFromArray:tempArray];
            }
            if(self.dingdanArray.count==dingdanListBean.count){
                self.tableView.mj_footer.hidden=YES;
            }else{
                self.tableView.mj_footer.hidden=NO;
            }
            [self.tableView reloadData];
        }else{
            [MBProgressHUD showError:dingdanListBean.message];
        }
    } Error:^(NSError *err) {
        [MBProgressHUD showError:@"网络连接失败"];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dingdanArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"dingdan";
    // 1.缓存中取
    DingDanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[DingDanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.dingdanDetailBean=self.dingdanArray[indexPath.row];
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //跳转到详情
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DingDanDetailBean *bean=self.dingdanArray[indexPath.row];
    
    return 200+bean.dishes.count*32;
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
//注意：事件类型是：`UIControlEventEditingChanged`
-(void)passConTextChange:(id)sender{
    UITextField* target=(UITextField*)sender;
    NSLog(@"%@",target.text);
   
    self.realname=target.text;
    self.pageIndex=0;
    [self getOrderList];

}
@end
