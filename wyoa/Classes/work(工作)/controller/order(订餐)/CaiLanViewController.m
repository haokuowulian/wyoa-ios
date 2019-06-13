//
//  CaiLanViewController.m
//  wyoa
//
//  Created by apple on 2018/8/19.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "CaiLanViewController.h"
#import "CaiLanTableViewCell.h"
#import "CaiLanListBean.h"
#import "CaiLanDetailbean.h"
#import "MJExtension.h"
#import "Extern.h"
#import "MJRefresh.h"
#import "JXTAlertManagerHeader.h"
#import "MBProgressHUD+MBProgressHUD.h"

@interface CaiLanViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,strong)NSMutableArray *cailanArray;
@property(nonatomic,strong)NSMutableArray *selectList;
@end

@implementation CaiLanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.selectList=[[NSMutableArray alloc]init];
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:v];
    [self.tableView registerNib:[UINib nibWithNibName:@"CaiLanTableViewCell" bundle:nil] forCellReuseIdentifier:@"cailan"];
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        self.pageIndex=0;
        [self getCaiLanList];
        
        
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        self.pageIndex++;
        [self getCaiLanList];
        
    }];
    self.pageIndex=0;
    [self getCaiLanList];
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice:) name:@"cailanRefresh" object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)notice:(id)sender{
    self.pageIndex=0;
    [self getCaiLanList];
    [self.selectList removeAllObjects];
   
}
-(void)buy{
    NSDecimalNumber *total=[NSDecimalNumber decimalNumberWithString:@"0"];
    NSString *ids=@"";
    if(self.selectList.count>0){
        for(int i=0;i<self.selectList.count;i++){
            CaiLanDetailbean *bean=self.selectList[i];
            total=[total decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:bean.total]];
            if(i==0){
                ids=bean.id;
            }else{
                ids=[NSString stringWithFormat:@"%@,%@",ids,bean.id];
            }
        }
         [self getTotal:total withIds:ids];
    }else{
        [MBProgressHUD showError:@"请选择需要购买的菜品"];
    }
   
}
- (void)viewDidAppear:(BOOL)animated{
    UILabel *label=[[UILabel alloc]init];
    label.text=@"我的菜篮";
    label.textColor=[UIColor colorWithHexString:@"333333"];;
    label.font=[UIFont systemFontOfSize:20.0f];
    self.tabBarController.navigationItem.titleView=label;
    
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithTitle:@"购买" style:(UIBarButtonItemStyleDone) target:self action:@selector(buy)];
    self.tabBarController.navigationItem.rightBarButtonItem = rightitem;
    [self.tabBarController.navigationItem.rightBarButtonItem setTintColor:kThemeColor];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cailanArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cailan";
    // 1.缓存中取
    CaiLanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[CaiLanTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CaiLanDetailbean *cailanDetailBean=self.cailanArray[indexPath.row];
    cell.cailanDetailBean=cailanDetailBean;
    for(int i=0;i<self.selectList.count;i++){
//        CaiLanDetailbean *bean=self.selectList[i];
//        if([bean.id isEqualToString:cailanDetailBean.id]){
            [cell.checkBox setOn:NO];
//        }
    }

    cell.checkAction = ^(BEMCheckBox *sender) {
           [self checkBoxClick:sender check:cailanDetailBean withArray:self.selectList ];
    };
    cell.deleteAction = ^(UIButton *sender) {
        [self delete:cailanDetailBean];
    };
    return  cell;
}
// 将方法抽出来放在外边看起来不至于让tableView的代理方法太臃肿
- (void) checkBoxClick:(BEMCheckBox *)checkBox check:(CaiLanDetailbean *)cailanDetailBean withArray:(NSMutableArray *)array
{
    
    if(checkBox.on){
        [array addObject:cailanDetailBean];
    }else{
        for(int i=0;i<self.selectList.count;i++){
            CaiLanDetailbean *bean=self.selectList[i];
            if([bean.id isEqualToString:cailanDetailBean.id]){
                [array removeObject:bean];
            }
        }
    }
    NSLog(@"--%@",array);
    
}
-(void)delete:(CaiLanDetailbean *)bean{
    [self alertWarn:bean];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //跳转到详情
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 155.0f;
}
#pragma mark 获取菜篮列表
-(void)getCaiLanList{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    NSString *userId=[userDefault objectForKey:@"userId"];
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"mess/getIPopuralityList.do",apikey];
    NSDictionary *params=@{@"userId":userId,
                           @"pageIndex":[NSString stringWithFormat:@"%ld",self.pageIndex],
                           @"pageSize":@"10"
                           };
    [CaiLanListBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
        [self.tableView.mj_header endRefreshing];
        CaiLanListBean *cailanListBean=[CaiLanListBean mj_objectWithKeyValues:dict];
        if(cailanListBean.success==1){
            NSMutableArray *tempArray=[CaiLanDetailbean mj_objectArrayWithKeyValuesArray:cailanListBean.data];
            if(self.pageIndex==0){
                self.cailanArray=tempArray;
            }else{
                [self.cailanArray addObjectsFromArray:tempArray];
            }
            if(self.self.cailanArray.count==cailanListBean.count){
                self.tableView.mj_footer.hidden=YES;
            }else{
                self.tableView.mj_footer.hidden=NO;
            }
            [self.tableView reloadData];
        
        }else{
             [MBProgressHUD showError:cailanListBean.message];
        }
    } Error:^(NSError *err) {
        [self.tableView.mj_header endRefreshing];
         [MBProgressHUD showError:@"网络连接失败"];
    }];
}

#pragma mark 总价提示
-(void)getTotal:(NSDecimalNumber *)total withIds:(NSString *)ids{
    [self jxt_showAlertWithTitle:@"提示" message:[NSString stringWithFormat:@"总价格：%@元",total] appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
        alertMaker.
        addActionCancelTitle(@"取消").
        addActionDestructiveTitle(@"确定");
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
       if (buttonIndex == 1) {
           [self jiesuan:total withIds:ids];
        }
    }];
}

#pragma mark 结算
-(void)jiesuan:(NSDecimalNumber *)total withIds:(NSString *)ids{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    NSString *userId=[userDefault objectForKey:@"userId"];
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"mess/saveInOrder.do",apikey];
    NSDictionary *params=@{@"userId":userId,
                           @"total":[NSString stringWithFormat:@"%@",total],
                           @"ids":ids
                           };
    [BaseBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
        BaseBean *baseBean=[BaseBean mj_objectWithKeyValues:dict];
        if(baseBean.success==1){
            [MBProgressHUD showError:@"购买成功"];
            //创建一个消息对象
            NSNotification * notice = [NSNotification notificationWithName:@"cailanRefresh" object:nil];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
        }else{
            [MBProgressHUD showError:[NSString stringWithFormat:@"购买失败:%@",baseBean.message]];
        }
    } Error:^(NSError *err) {
        [MBProgressHUD showError:@"网络连接失败"];
    }];
}

#pragma mark 删除警告
-(void)alertWarn:(CaiLanDetailbean *)bean{
    [self jxt_showAlertWithTitle:@"提示" message:[NSString stringWithFormat:@"确定删除该菜品吗？"] appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
        alertMaker.
        addActionCancelTitle(@"取消").
        addActionDestructiveTitle(@"确定");
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
        if (buttonIndex == 1) {
            [self deleteCai:bean];
        }
    }];
}

#pragma mark 删除菜品
-(void)deleteCai:(CaiLanDetailbean *)bean{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"mess/delInPreOrderById.do",apikey];
    NSDictionary *params=@{@"id":bean.id
                           };
    [BaseBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
        BaseBean *baseBean=[BaseBean mj_objectWithKeyValues:dict];
        if(baseBean.success==1){
            [self.selectList removeObject:bean];
            [self.tableView reloadData];
            [MBProgressHUD showError:@"删除成功"];
            //创建一个消息对象
            NSNotification * notice = [NSNotification notificationWithName:@"cailanRefresh" object:nil];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
        }else{
            [MBProgressHUD showError:[NSString stringWithFormat:@"删除失败:%@",baseBean.message]];
        }
    } Error:^(NSError *err) {
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
