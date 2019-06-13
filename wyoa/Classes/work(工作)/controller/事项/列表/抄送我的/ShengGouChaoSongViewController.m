//
//  ShengGouChaoSongViewController.m
//  wyoa
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "ShengGouChaoSongViewController.h"
#import "ShenGouTableViewCell.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "ShengGouListBean.h"
#import "ShengGouDetailBean.h"
#import "Extern.h"
#import "MBProgressHUD+MBProgressHUD.h"
#import "ShengGouDetailViewController.h"
#import "TimeUtil.h"
@interface ShengGouChaoSongViewController ()
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,strong)NSMutableArray *shenggouArray;
@end

@implementation ShengGouChaoSongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(!self.fillformDate){
        self.fillformDate=[TimeUtil getCurrentMonth];
        
    }
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:v];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShenGouTableViewCell" bundle:nil] forCellReuseIdentifier:@"shengou"];
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
    [MBProgressHUD showMessage:@"正在获取抄送我的物品申购..."];
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
    return  self.shenggouArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"shengou";
    // 1.缓存中取
    ShenGouTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[ShenGouTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.shenggouDetailBean=self.shenggouArray[indexPath.row];
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //跳转到详情
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"ShengGouDetail" bundle:nil];
    ShengGouDetailViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"shenggouDetail"];
    ShengGouDetailBean *bean=self.shenggouArray[indexPath.row];
    controller.id=bean.id;
    controller.needDeal=NO;
    controller.title=[NSString stringWithFormat:@"%@的物品申购",bean.realname];
    [self.navigationController pushViewController:controller animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 147.5f;
}

#pragma mark 获取抄送我的申购列表
-(void)getChaoSong{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *userId=[userDefault objectForKey:@"userId"];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"oaOffice/getInUnmessageList.do",apikey];
    NSDictionary *params=@{@"userId":userId,
                           @"pageIndex":[NSString stringWithFormat:@"%ld",self.pageIndex],
                           @"pageSize":@"10",
                           @"matterType":@"5",
                           @"fillformDate":self.fillformDate
                           };
    [ShengGouListBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
        [MBProgressHUD hideHUD];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        ShengGouListBean *shenggouListBean=[ShengGouListBean mj_objectWithKeyValues:dict];
        if(shenggouListBean.success==1){
            NSMutableArray *tempArray=[ShengGouDetailBean mj_objectArrayWithKeyValuesArray:shenggouListBean.data];
            if(self.pageIndex==0){
                self.shenggouArray=tempArray;
            }else{
                [self.shenggouArray addObjectsFromArray:tempArray];
            }
            if(self.self.shenggouArray.count==shenggouListBean.count){
                self.tableView.mj_footer.hidden=YES;
            }else{
                self.tableView.mj_footer.hidden=NO;
            }
            [self.tableView reloadData];
        }else{
            [MBProgressHUD showError:shenggouListBean.message];
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
