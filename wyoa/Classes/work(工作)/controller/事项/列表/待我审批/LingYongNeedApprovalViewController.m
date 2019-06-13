//
//  LingYongNeedApprovalViewController.m
//  wyoa
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "LingYongNeedApprovalViewController.h"
#import "LingYongTableViewCell.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "LingYongListBean.h"
#import "LingYongDetailBean.h"
#import "Extern.h"
#import "MBProgressHUD+MBProgressHUD.h"
#import "LingYongDetailViewController.h"
#import "TimeUtil.h"
@interface LingYongNeedApprovalViewController ()
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,strong)NSMutableArray *lingyongArray;
@end

@implementation LingYongNeedApprovalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    if(!self.fillformDate){
        self.fillformDate=[TimeUtil getCurrentMonth];
        
    }
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:v];
    [self.tableView registerNib:[UINib nibWithNibName:@"LingYongTableViewCell" bundle:nil] forCellReuseIdentifier:@"lingyong"];
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        self.pageIndex=0;
        [self getShenPi];
        
        
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        self.pageIndex++;
        [self getShenPi];
        
    }];
    
    self.pageIndex=0;
    [MBProgressHUD showMessage:@"正在获取待审批物品领用..."];
    [self getShenPi];
    
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice:) name:@"shixiangRefresh" object:nil];
    [center addObserver:self selector:@selector(getDate:) name:@"getDate" object:nil];
}

-(void)getDate:(id)sender{
    self.fillformDate=[sender object];
    self.pageIndex=0;
    [self getShenPi];
}

-(void)notice:(id)sender{
    self.pageIndex=0;
    [self getShenPi];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.lingyongArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"lingyong";
    // 1.缓存中取
    LingYongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[LingYongTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.lingyongDetailBean=self.lingyongArray[indexPath.row];
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //跳转到详情
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"LingYongDetail" bundle:nil];
    LingYongDetailViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"lingyongDetail"];
    LingYongDetailBean *bean=self.lingyongArray[indexPath.row];
    controller.id=bean.id;
    controller.needDeal=YES;
    controller.title=[NSString stringWithFormat:@"%@的物品领用",bean.realname];
    [self.navigationController pushViewController:controller animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 147.5f;
}

#pragma mark 获取待审批请假列表
-(void)getShenPi{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *userId=[userDefault objectForKey:@"userId"];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"oaOffice/doDealWithTransfer.do",apikey];
    NSDictionary *params=@{@"userId":userId,
                           @"pageIndex":[NSString stringWithFormat:@"%ld",self.pageIndex],
                           @"pageSize":@"10",
                           @"fillformDate":self.fillformDate
                           };
    NSLog(@"%@",url);
    [LingYongListBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
        [MBProgressHUD hideHUD];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        LingYongListBean *lingyongListBean=[LingYongListBean mj_objectWithKeyValues:dict];
        if(lingyongListBean.success==1){
            NSMutableArray *tempArray=[LingYongDetailBean mj_objectArrayWithKeyValuesArray:lingyongListBean.data];
            if(self.pageIndex==0){
                self.lingyongArray=tempArray;
            }else{
                [self.lingyongArray addObjectsFromArray:tempArray];
            }
            if(self.self.lingyongArray.count==lingyongListBean.count){
                self.tableView.mj_footer.hidden=YES;
            }else{
                self.tableView.mj_footer.hidden=NO;
            }
            [self.tableView reloadData];
        }else{
            [MBProgressHUD showError:lingyongListBean.message];
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
