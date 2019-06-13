//
//  StaffViewController.m
//  wyoa
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "StaffViewController.h"
#import "StaffTableViewCell.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "StaffResultBean.h"
#import "StaffDetailBean.h"
#import "Extern.h"
#import "MBProgressHUD+MBProgressHUD.h"
#import "AddStaffViewController.h"
#import "StaffDetailViewController.h"


@interface StaffViewController ()
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,strong)NSMutableArray *staffArray;
@property(nonatomic,copy)NSString *name;
@end

@implementation StaffViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name=@"";
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *roleId=[userDefault objectForKey:@"roleId"];
    if([roleId isEqualToString:@"1"]||
       [roleId isEqualToString:@"8"]||
       [roleId isEqualToString:@"9"]||
       [roleId isEqualToString:@"10"]||
       [roleId isEqualToString:@"11"]||
       [roleId isEqualToString:@"13"]
       ){
        UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithTitle:@"新增" style:(UIBarButtonItemStyleDone) target:self action:@selector(add)];
        [rightitem setTintColor:[UIColor colorWithHexString:@"5590de"]];
        self.navigationItem.rightBarButtonItem = rightitem;
    }
   
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:v];
     [self.searchText addTarget:self action:@selector(passConTextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.tableView registerNib:[UINib nibWithNibName:@"StaffTableViewCell" bundle:nil] forCellReuseIdentifier:@"staff"];
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        self.pageIndex=0;
        [self getStaff];
        
        
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        self.pageIndex++;
        [self getStaff];
        
    }];
    
    self.pageIndex=0;
    [MBProgressHUD showMessage:@"正在获取人员去向数据..."];
    [self getStaff];
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice:) name:@"staffRefresh" object:nil];
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)notice:(id)sender{
    self.pageIndex=0;
    [self getStaff];
}

#pragma  mark 前往新增人员去向
-(void)add{
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"AddStaff" bundle:nil];
    AddStaffViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"addStaff"];
    controller.title=@"新增去向";
    [self.navigationController pushViewController:controller animated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.staffArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"staff";
    // 1.缓存中取
    StaffTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[StaffTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.staffDetailBean=self.staffArray[indexPath.row];
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //跳转到详情
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"StaffDetail" bundle:nil];
    StaffDetailViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"staffDetail"];
    StaffDetailBean *bean=self.staffArray[indexPath.row];
    controller.title=[NSString stringWithFormat:@"%@的去向",bean.name];
    controller.staffDetailBean=bean;
    [self.navigationController pushViewController:controller animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 147.5f;
}

#pragma mark 获取人员去向
-(void)getStaff{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
//    NSString *userId=[userDefault objectForKey:@"userId"];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"noteNew/getLoginUserContact.do",apikey];
    NSDictionary *params=@{@"pageIndex":[NSString stringWithFormat:@"%ld",self.pageIndex],
                           @"pageSize":@"10",
                           @"name":self.name
                           };
    [StaffResultBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
        [MBProgressHUD hideHUD];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        StaffResultBean *staffResultBean=[StaffResultBean mj_objectWithKeyValues:dict];
        if(staffResultBean.success==1){
            NSMutableArray *tempArray=[StaffDetailBean mj_objectArrayWithKeyValuesArray:staffResultBean.data];
            if(self.pageIndex==0){
                self.staffArray=tempArray;
            }else{
                [self.staffArray addObjectsFromArray:tempArray];
            }
            if(self.staffArray.count==staffResultBean.count){
                self.tableView.mj_footer.hidden=YES;
            }else{
                self.tableView.mj_footer.hidden=NO;
            }
            [self.tableView reloadData];
        }else{
            [MBProgressHUD showError:staffResultBean.message];
        }
    } Error:^(NSError *err) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"网络连接失败"];
    }];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *roleId=[userDefault objectForKey:@"roleId"];
    if([roleId isEqualToString:@"1"]||
       [roleId isEqualToString:@"8"]||
       [roleId isEqualToString:@"9"]||
       [roleId isEqualToString:@"10"]||
       [roleId isEqualToString:@"11"]||
       [roleId isEqualToString:@"13"]
       ){
    return YES;
    }else{
        return  NO;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:
(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //    NSUInteger row = [indexPath row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

/**
 *  iOS8 以上
 *
 */
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath

{
   
    // 添加一个删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了删除");
        StaffDetailBean *bean=self.staffArray[indexPath.row];
        [self delete:bean at:indexPath];
    }];
    deleteRowAction.backgroundColor = [UIColor colorWithHexString:@"ef5749"];
    
    // 添加一个修改按钮
    UITableViewRowAction *updateRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"修改" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"AddStaff" bundle:nil];
        AddStaffViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"addStaff"];
        StaffDetailBean *bean=self.staffArray[indexPath.row];
        controller.indexPath=indexPath;
        controller.staffDetailBean=bean;
        controller.title=@"修改去向";
        [self.navigationController pushViewController:controller animated:YES];
        
        
        
    }];
    
    updateRowAction.backgroundColor = [UIColor colorWithHexString:@"7a69fa"];
    
    // 将设置好的按钮放到数组中返回
    
    return @[deleteRowAction, updateRowAction];
    
    
}
#pragma mark 删除
-(void)delete:(StaffDetailBean *)bean at:(NSIndexPath *)indexPath{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *userId=[userDefault objectForKey:@"userId"];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"noteNew/delInUserLocal.do",apikey];
    NSDictionary *params=@{@"userId":userId,
                           @"id":bean.id
                           };
    [BaseBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
        BaseBean *basebean=[BaseBean mj_objectWithKeyValues:dict];
        if(basebean.success==1){
            // 1. 更新数据
            [self.staffArray removeObjectAtIndex:indexPath.row];
            // 2. 更新UI
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }else{
            [MBProgressHUD showError:basebean.message];
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

//注意：事件类型是：`UIControlEventEditingChanged`
-(void)passConTextChange:(id)sender{
    UITextField* target=(UITextField*)sender;
    NSLog(@"%@",target.text);
    self.name=target.text;
    self.pageIndex=0;
    [self getStaff];
}

@end
