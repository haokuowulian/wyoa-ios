//
//  MailListViewController.m
//  wyoa
//
//  Created by apple on 2018/8/13.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "MailListViewController.h"
#import "ContactBean.h"
#import "ContractListBean.h"
#import "MBProgressHUD+MBProgressHUD.h"
#import <MJExtension/MJExtension.h>
#import "ContractTableViewCell.h"
#import <MJRefresh/MJRefresh.h>
#import "UserInfoResultBean.h"
#import "ContactDetailViewController.h"
#import "Extern.h"

@interface MailListViewController ()<UITableViewDataSource,UITableViewDelegate>
// 所有的indexsTitles
@property(nonatomic,strong)NSArray *allIndexTitles;
// 存放索引对应的下标
@property(nonatomic,strong)NSMutableArray *sectionIndexs;
// dataSource
@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)NSMutableArray *alldata;
@property(nonatomic,strong)  UILabel *label;

@end

@implementation MailListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.label=[[UILabel alloc]init];
      [self.tableView registerNib:[UINib nibWithNibName:@"ContractTableViewCell" bundle:nil] forCellReuseIdentifier:@"contract"];
    [self getContacts];
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
   
        [self getContacts];
        [self.tableView.mj_header setState:MJRefreshStateIdle];
    }];
    [self.searchText addTarget:self action:@selector(passConTextChange:) forControlEvents:UIControlEventEditingChanged];

    
    
}
#pragma mark 获取通讯录
-(void)getContacts{
//     [MBProgressHUD showMessage:@"正在获取通讯录..."];
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
  NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"oaCustom/getLoginUserContact.do",apikey];
    [ContractListBean BeanByPostWithUrl:url Params:nil Success:^(NSDictionary *dict) {
         [MBProgressHUD hideHUD];
         [self.tableView.mj_header endRefreshing];
        ContractListBean *contractListBean=[ContractListBean mj_objectWithKeyValues:dict];
        if(contractListBean.success==1){
             NSMutableArray *tempArray=[ContactBean mj_objectArrayWithKeyValuesArray:contractListBean.data];
            self.alldata=tempArray;
            
            [self setupInitialAllDataArrayWithContacts:tempArray];
            [self.tableView reloadData];
         
            self.label.text=[NSString stringWithFormat:@"共%@位联系人",contractListBean.total];
            self.label.frame=CGRectMake(0, 500, 20, 44);
            self.label.textColor=[UIColor grayColor];
            self.label.backgroundColor=[UIColor colorWithHexString:@"f7f7f7"];
            self.label.textAlignment = UITextAlignmentCenter;
            self.label.font=[UIFont systemFontOfSize:15.0f];
            self.tableView.tableFooterView=self.label;

        }
    } Error:^(NSError *err) {
        [self.tableView.mj_header endRefreshing];
        [MBProgressHUD hideHUD];

    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 设置初始的所有数据
- (void)setupInitialAllDataArrayWithContacts:(NSArray<ContactBean *> *)contacts {
    // 按照 ZJContact中的name来处理
    SEL nameSelector = @selector(name);
    // 单例对象
    UILocalizedIndexedCollation *localIndex = [UILocalizedIndexedCollation currentCollation];
    // 获得当前语言下的所有的indexTitles
    _allIndexTitles = localIndex.sectionTitles;
    // 初始化所有数据的数组
    _data = [NSMutableArray arrayWithCapacity:_allIndexTitles.count];
    // 为每一个indexTitle 生成一个可变的数组
    for (int i = 0; i<_allIndexTitles.count; i++) {
        // 初始化数组
        [self.data addObject:[NSMutableArray array]];
    }
    // 初始化有效的sectionIndexs
    _sectionIndexs = [NSMutableArray arrayWithCapacity:_allIndexTitles.count];
    for (ContactBean *contact in contacts) {
        if (contact == nil) continue;
        
        // 获取到这个contact的name的首字母对应的indexTitle
        // 注意这里必须使用对象, 这个selector也是有要求的
        // 必须是这个对象中的selector, 并且不能有参数, 必须返回字符串
        // 所以这里直接使用 name 属性的get方法就可以
        NSInteger index = [localIndex sectionForObject:contact collationStringSelector:nameSelector];
        
        // 处理多音字 例如 "曾" -->> 会被当做 ceng 来处理, 其他需要处理的多音字类似
        if ([contact.name hasPrefix:@"曾"]) {
            index = [_allIndexTitles indexOfObject:@"Z"];
        }
        if ([contact.name hasPrefix:@"沈"]) {
            index = [_allIndexTitles indexOfObject:@"S"];
        }
        // 将这个contact添加到对应indexTitle的数组中去
        [_data[index] addObject:contact];
    }
    
    for (int i=0; i<_data.count; i++) {
        NSArray *temp = _data[i];
        if (temp.count != 0) { // 取出不为空的部分对应的indexTitle
            [self.sectionIndexs addObject:[NSNumber numberWithInt:i]];
        }
        // 排序每一个数组
        _data[i] = [localIndex sortedArrayFromArray:temp collationStringSelector:nameSelector];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionIndexs.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger index = [_sectionIndexs[section] integerValue];
    NSArray *temp = _data[index];
    return temp.count;
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const kCellId = @"contract";
    ContractTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    
    if (cell == nil) {
        cell = [[ContractTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellId];
    }
    NSInteger index = [_sectionIndexs[indexPath.section] integerValue];
    NSArray *temp = _data[index];
    cell.contractBean= (ContactBean *)temp[indexPath.row];
   
    return cell;
}
// sectionHeader
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSInteger index = [_sectionIndexs[section] integerValue];
    return _allIndexTitles[index];
}

// 这个方法是返回索引的数组, 我们需要根据之前获取到的两个数组来取到我们需要的
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *indexTitles = [NSMutableArray arrayWithCapacity:_sectionIndexs.count];
    // 遍历索引的下标数组, 然后根据下标取出_allIndexTitles对应的索引字符串
    for (NSNumber *number in _sectionIndexs) {
        NSInteger index = number.integerValue;
        [indexTitles addObject:_allIndexTitles[index]];
    }
    return indexTitles;
}

// 可以相应点击的某个索引, 也可以为索引指定其对应的特定的section, 默认是 section == index
// 返回点击索引列表上的索引时tableView应该滚动到那一个section去
// 这里我们的tableView的section和索引的个数相同, 所以直接返回索引的index即可
// 如果不相同, 则需要自己相应的返回自己需要的section
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    NSLog(@"%@---%ld", title, index);
   
    return index;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.0f;
}
#pragma mark 跳转到联系人详情或选择联系人
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ContactBean *bean=_data[[_sectionIndexs[indexPath.section] integerValue]][indexPath.row];
    if(_isFromSelect){
        if(_isFromTiaoBan){
            NSNotification * notice = [NSNotification notificationWithName:@"selectUserHuanBan" object:bean];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
        }else{
            //创建一个消息对象
            NSNotification * notice = [NSNotification notificationWithName:@"selectUser" object:bean];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
        }
      
       
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"ContactDetail" bundle:nil];
        ContactDetailViewController *controll=[storyboard instantiateViewControllerWithIdentifier:@"contactDetail"];
        controll.userInfoBean=bean;
        [self.navigationController pushViewController:controll animated:YES];
    }
     [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
//注意：事件类型是：`UIControlEventEditingChanged`
-(void)passConTextChange:(id)sender{
    UITextField* target=(UITextField*)sender;
    NSLog(@"%@",target.text);
    NSMutableArray<ContactBean *> *tempArray=[NSMutableArray array];
    if(target.text.length>0){
     tempArray= [ContactBean searchText:target.text inDataArray:self.alldata];
    self.data=tempArray;
    }else{
      tempArray=self.alldata;
       
    }
    self.label.text=[NSString stringWithFormat:@"共%ld位联系人",tempArray.count];
     [self setupInitialAllDataArrayWithContacts:tempArray];
     [self.tableView reloadData];
}

@end
