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
@interface StaffViewController ()
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,strong)NSMutableArray *staffArray;
@end

@implementation StaffViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:v];
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
                           @"pageSize":@"10"
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
    return YES;
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
        
        // 1. 更新数据
        
                [self.staffArray removeObjectAtIndex:indexPath.row];
        
        // 2. 更新UI
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }];
    
    // 删除一个置顶按钮
    
    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"置顶" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        NSLog(@"点击了置顶");
        
        // 1. 更新数据
        
        //            [_allDataArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
        
        // 2. 更新UI
        
        NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        
        [tableView moveRowAtIndexPath:indexPath toIndexPath:firstIndexPath];
        
    }];
    
    topRowAction.backgroundColor = [UIColor lightGrayColor];
    
    // 添加一个更多按钮
    
    UITableViewRowAction *moreRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"更多" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        NSLog(@"点击了更多");
        
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
        
    }];
    
    moreRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    // 将设置好的按钮放到数组中返回
    
    return @[deleteRowAction, topRowAction, moreRowAction];
    
    //    return @[deleteRowAction,moreRowAction];
    
}

#pragma mark - TableView 占位图

- (UIImage *)nodata_noDataViewImage {
    return [UIImage imageNamed:@"neirong"];
}

- (NSString *)nodata_noDataViewMessage {
    return @"还没有内容哦";
}

- (UIColor *)nodata_noDataViewMessageColor {
    return [UIColor colorWithHexString:@"999999"];
}
@end
