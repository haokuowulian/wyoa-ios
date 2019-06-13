//
//  QingJiaChaoSongViewController.m
//  wyoa
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "QingJiaChaoSongViewController.h"
#import "QingJiaTableViewCell.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "QingJiaListBean.h"
#import "QingJiaDetailBean.h"
#import "Extern.h"
#import "MBProgressHUD+MBProgressHUD.h"
#import "QingJiaDetailViewController.h"
#import "TimeUtil.h"
@interface QingJiaChaoSongViewController ()
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,strong)NSMutableArray *qingjiaArray;
@end

@implementation QingJiaChaoSongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(!self.fillformDate){
        self.fillformDate=[TimeUtil getCurrentMonth];
        
    }
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:v];
    [self.tableView registerNib:[UINib nibWithNibName:@"QingJiaTableViewCell" bundle:nil] forCellReuseIdentifier:@"qingjia"];
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        self.pageIndex=0;
        [self getChaoSong];
        
        
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        self.pageIndex++;
        [self getChaoSong];
        
    }];
    
    self.pageIndex=0;
    [MBProgressHUD showMessage:@"正在获取抄送我的事假..."];
    [self getChaoSong];
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(getDate:) name:@"getDate" object:nil];
}

-(void)getDate:(id)sender{
    self.fillformDate=[sender object];
    self.pageIndex=0;
    [self getChaoSong];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.qingjiaArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"qingjia";
    // 1.缓存中取
    QingJiaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[QingJiaTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.qingjiaDetailBean=self.qingjiaArray[indexPath.row];
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //跳转到详情
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"QingJiaDetail" bundle:nil];
    QingJiaDetailViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"qingjiaDetail"];
    QingJiaDetailBean *bean=self.qingjiaArray[indexPath.row];
    controller.id=bean.id;
    controller.needDeal=NO;
    controller.title=[NSString stringWithFormat:@"%@的事假",bean.realname];
    [self.navigationController pushViewController:controller animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 147.5f;
}

#pragma mark 获取抄送我的请假列表
-(void)getChaoSong{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *userId=[userDefault objectForKey:@"userId"];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"oaOffice/getInUnmessageList.do",apikey];
    NSDictionary *params=@{@"userId":userId,
                           @"pageIndex":[NSString stringWithFormat:@"%ld",self.pageIndex],
                           @"pageSize":@"10",
                           @"matterType":@"0",
                           @"fillformDate":self.fillformDate
                           };
    [QingJiaListBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
        [MBProgressHUD hideHUD];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        QingJiaListBean *qingjiaListBean=[QingJiaListBean mj_objectWithKeyValues:dict];
        if(qingjiaListBean.success==1){
            NSMutableArray *tempArray=[QingJiaDetailBean mj_objectArrayWithKeyValuesArray:qingjiaListBean.data];
            if(self.pageIndex==0){
                self.qingjiaArray=tempArray;
            }else{
                [self.qingjiaArray addObjectsFromArray:tempArray];
            }
            if(self.self.qingjiaArray.count==qingjiaListBean.count){
                self.tableView.mj_footer.hidden=YES;
            }else{
                self.tableView.mj_footer.hidden=NO;
            }
            [self.tableView reloadData];
        }else{
            [MBProgressHUD showError:qingjiaListBean.message];
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
