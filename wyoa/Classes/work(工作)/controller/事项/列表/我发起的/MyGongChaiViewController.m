//
//  MyGongChaiViewController.m
//  wyoa
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "MyGongChaiViewController.h"
#import "GongChaiTableViewCell.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "GongChaiListBean.h"
#import "GongChaiDetailBean.h"
#import "Extern.h"
#import "MBProgressHUD+MBProgressHUD.h"
#import "GongChaiDetailViewController.h"
#import "TimeUtil.h"
@interface MyGongChaiViewController ()
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,strong)NSMutableArray *gongchaiArray;
@end

@implementation MyGongChaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    if(!self.fillformDate){
        self.fillformDate=[TimeUtil getCurrentMonth];
        
    }
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:v];
    [self.tableView registerNib:[UINib nibWithNibName:@"GongChaiTableViewCell" bundle:nil] forCellReuseIdentifier:@"gongchai"];
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        self.pageIndex=0;
        [self getMyGongChai];
        
        
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        self.pageIndex++;
        [self getMyGongChai];
        
    }];
    
    self.pageIndex=0;
    [MBProgressHUD showMessage:@"正在获取我的公差..."];
    [self getMyGongChai];
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(getDate:) name:@"getDate" object:nil];
}

-(void)getDate:(id)sender{
    self.fillformDate=[sender object];
    self.pageIndex=0;
    [self getMyGongChai];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.gongchaiArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"gongchai";
    // 1.缓存中取
    GongChaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[GongChaiTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.gongchaiDetailBean=self.gongchaiArray[indexPath.row];
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //跳转到详情
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"GongChaiDetail" bundle:nil];
    GongChaiDetailViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"gongchaiDetail"];
    GongChaiDetailBean *bean=self.gongchaiArray[indexPath.row];
    controller.id=bean.id;
    controller.needDeal=NO;
    controller.title=[NSString stringWithFormat:@"%@的公差",bean.realname];
    [self.navigationController pushViewController:controller animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 147.5f;
}

#pragma mark 获取我的公差列表
-(void)getMyGongChai{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *userId=[userDefault objectForKey:@"userId"];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"oaOffice/getInlistTrip.do",apikey];
    NSDictionary *params=@{@"userId":userId,
                           @"pageIndex":[NSString stringWithFormat:@"%ld",self.pageIndex],
                           @"pageSize":@"10",
                           @"fillformDate":self.fillformDate
                           };
    [GongChaiListBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
        [MBProgressHUD hideHUD];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        GongChaiListBean *gongchaiListBean=[GongChaiListBean mj_objectWithKeyValues:dict];
        if(gongchaiListBean.success==1){
            NSMutableArray *tempArray=[GongChaiDetailBean mj_objectArrayWithKeyValuesArray:gongchaiListBean.data];
            if(self.pageIndex==0){
                self.gongchaiArray=tempArray;
            }else{
                [self.gongchaiArray addObjectsFromArray:tempArray];
            }
            if(self.self.gongchaiArray.count==gongchaiListBean.count){
                self.tableView.mj_footer.hidden=YES;
            }else{
                self.tableView.mj_footer.hidden=NO;
            }
            [self.tableView reloadData];
        }else{
            [MBProgressHUD showError:gongchaiListBean.message];
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
