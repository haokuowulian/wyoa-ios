//
//  HangYeNewsViewController.m
//  wyoa
//
//  Created by apple on 2018/8/14.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "HangYeNewsViewController.h"
#import "MJRefresh.h"
#import "NewsTableViewCell.h"
#import "MBProgressHUD+MBProgressHUD.h"
#import "Extern.h"
#import "NewsListBean.h"
#import "NewsDetailBean.h"
#import "MJExtension.h"
#import "HangYeNewsDetailViewController.h"

@interface HangYeNewsViewController ()
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,strong)NSMutableArray *newsArray;
@end

@implementation HangYeNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:v];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"news"];
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        self.pageIndex=0;
        [self getNews];
        
        
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        self.pageIndex++;
        [self getNews];
        
    }];
    [MBProgressHUD showMessage:@"正在获取行业新闻..."];
    self.pageIndex=0;
    [self getNews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return  self.newsArray.count;
    return self.newsArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"news";
    // 1.缓存中取
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.newsDetailBean=self.newsArray[indexPath.row];
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //跳转到详情
     [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"HangYeNewsDetail" bundle:nil];
    HangYeNewsDetailViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"hangYeNewsDetail"];
    NewsDetailBean *bean=self.newsArray[indexPath.row];
    controller.title=@"新闻详情";
    controller.id=bean.id;
    [self.navigationController pushViewController:controller animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 76.0f;
}

#pragma mark 获取新闻
-(void)getNews{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"noteNew/getInNewsList.do",apikey];
    NSDictionary *params=@{@"pageIndex":[NSString stringWithFormat:@"%ld",self.pageIndex],
                           @"pageSize":@"10"
                           };
    [NewsListBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
        [MBProgressHUD hideHUD];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        NewsListBean *newsListBean=[NewsListBean mj_objectWithKeyValues:dict];
        if(newsListBean.success==1){
            NSMutableArray *tempArray=[NewsDetailBean mj_objectArrayWithKeyValuesArray:newsListBean.data];
            if(self.pageIndex==0){
                self.newsArray=tempArray;
            }else{
                [self.newsArray addObjectsFromArray:tempArray];
            }
            if(self.newsArray.count==newsListBean.count){
                self.tableView.mj_footer.hidden=YES;
            }else{
                self.tableView.mj_footer.hidden=NO;
            }
            [self.tableView reloadData];
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
