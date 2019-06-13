//
//  DingCanViewController.m
//  wyoa
//
//  Created by apple on 2018/8/19.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "DingCanViewController.h"
#import "HWOptionButton.h"
#import "DingCanTableViewCell.h"
#import "MJRefresh.h"
#import "MBProgressHUD+MBProgressHUD.h"
#import "Extern.h"
#import "DingCanListBean.h"
#import "DingCanDetailBean.h"
#import "MJExtension.h"
#import "DingCanTableViewCell.h"
#import "TimeUtil.h"
#import "JXTAlertManagerHeader.h"

@interface DingCanViewController ()<HWOptionButtonDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) HWOptionButton *optionButton;
@property(nonatomic,assign)NSInteger foodlistType;
@property(nonatomic,assign)NSInteger currentType;
@property(nonatomic,copy)NSMutableArray *dingcanArray;
@property(nonatomic,assign)NSInteger salesStatus;
@property(nonatomic,copy)NSString *selectDate;
@property(nonatomic,copy)NSString *eatTime;

@end

@implementation DingCanViewController


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
- (void)viewDidAppear:(BOOL)animated{
    self.salesStatus=0;
    self.segment.selectedSegmentIndex=0;
    [self creatControl];
    self.tabBarController.navigationItem.titleView=self.optionButton;
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
     [self setTableView];
}

- (void)creatControl
{
    HWOptionButton *optionBtn = [[HWOptionButton alloc] initWithFrame:CGRectMake(50, 100, 110, 44)];
    optionBtn.array = @[@"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", @"星期日"];
    optionBtn.delegate = self;
    optionBtn.showSearchBar = NO;
    self.optionButton = optionBtn;
    [self getType:optionBtn isCurrent:YES];
}
-(void)didSelectOptionInHWOptionButton:(HWOptionButton *)optionButton{
    [self getType:optionButton isCurrent:NO];
    [self getFoodList:@"0" withTableView:self.zaocanTableView];
    [self getFoodList:@"1" withTableView:self.wucanTableView];
    [self getFoodList:@"2" withTableView:self.wancanTableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dingcanArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"dingcan";

    DingCanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
       cell = [[DingCanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    if(self.dingcanArray&&self.dingcanArray.count>0){
         DingCanDetailBean *bean=self.dingcanArray[indexPath.row];
        cell.dingcanDetailBean=bean;
       
    cell.addAction = ^(UIButton *sender) {
            [self addNum:bean];
        };
    }
    
   
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}
#pragma mark 添加数量
-(void)addNum:(DingCanDetailBean *)bean{
    [self jxt_showAlertWithTitle:@"提示" message:@"请填写购餐份数" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
        alertMaker.
        addActionCancelTitle(@"取消").
        addActionDestructiveTitle(@"确定");
        
        [alertMaker addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            [textField setKeyboardType:UIKeyboardTypeNumberPad];
            [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            textField.text=@"1";
        }];
        
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
        if (buttonIndex == 1) {
            UITextField *textField = alertSelf.textFields.lastObject;
            NSLog(@"%@---------",textField.text);
            if(textField.text.length>0){
                [self addToCaiLan:[textField.text intValue]withBean:bean];
            }
        }
    }];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //跳转到详情
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0f;
}

#pragma mark 获取日期type
-(void)getType:(HWOptionButton *)optionButton isCurrent:(Boolean )isCurrent{
    if([optionButton.title isEqualToString:@"星期一"]){
        if(isCurrent){
            self.currentType=1;
        }
        self.foodlistType=1;
    }else if([optionButton.title isEqualToString:@"星期二"]){
        if(isCurrent){
            self.currentType=2;
        }
        self.foodlistType=2;
    }else if([optionButton.title isEqualToString:@"星期三"]){
        if(isCurrent){
            self.currentType=3;
        }
        self.foodlistType=3;
    }else if([optionButton.title isEqualToString:@"星期四"]){
        if(isCurrent){
            self.currentType=4;
        }
        self.foodlistType=4;
    }else if([optionButton.title isEqualToString:@"星期五"]){
        if(isCurrent){
            self.currentType=5;
        }
        self.foodlistType=5;
    }else if([optionButton.title isEqualToString:@"星期六"]){
        if(isCurrent){
            self.currentType=6;
        }
        self.foodlistType=6;
    }else if([optionButton.title isEqualToString:@"星期日"]){
        if(isCurrent){
            self.currentType=7;
        }
        self.foodlistType=7;
    }
    
    if(self.foodlistType>=self.currentType){
       self.eatTime=[TimeUtil getNDay: self.foodlistType-self.currentType];
    }else{
       self.eatTime=[TimeUtil getNDay: self.foodlistType-self.currentType+7];
        
    }
}
#pragma mark 初始化tableView
-(void)setTableView{
    [MBProgressHUD showMessage:@"正在获取菜品信息..."];
    self.zaocanTableView.hidden=NO;
    self.wucanTableView.hidden=YES;
    self.wancanTableView.hidden=YES;
    
    self.zaocanTableView.dataSource=self;
    self.zaocanTableView.delegate=self;
    self.wucanTableView.dataSource=self;
    self.wucanTableView.delegate=self;
    self.wancanTableView.dataSource=self;
    self.wancanTableView.delegate=self;
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.zaocanTableView setTableFooterView:v];
    [self.wucanTableView setTableFooterView:v];
    [self.wancanTableView setTableFooterView:v];
    
    [self.zaocanTableView registerNib:[UINib nibWithNibName:@"DingCanTableViewCell" bundle:nil] forCellReuseIdentifier:@"dingcan"];
    [self.wucanTableView registerNib:[UINib nibWithNibName:@"DingCanTableViewCell" bundle:nil] forCellReuseIdentifier:@"dingcan"];
    [self.wancanTableView registerNib:[UINib nibWithNibName:@"DingCanTableViewCell" bundle:nil] forCellReuseIdentifier:@"dingcan"];
   
     [self getFoodList:@"0" withTableView:self.zaocanTableView];
     [self getFoodList:@"1" withTableView:self.wucanTableView];
     [self getFoodList:@"2" withTableView:self.wancanTableView];
    
    self.zaocanTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getFoodList:@"0" withTableView:self.zaocanTableView];
        
    }];
    self.wucanTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getFoodList:@"1" withTableView:self.wucanTableView];
        
    }];
    self.wancanTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getFoodList:@"2" withTableView:self.wancanTableView];
        
    }];
}

#pragma mark 获取菜品列表
-(void)getFoodList:(NSString *)salesStatus withTableView:(UITableView *)tableView{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"mess/getInFoodList.do",apikey];
    NSLog(@"111111111");
    NSDictionary *params=@{@"foodlistType":[NSString stringWithFormat:@"%ld",(long)self.foodlistType],
                           @"salesStatus":salesStatus
                           };
    [DingCanListBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
        [MBProgressHUD hideHUD];
        NSLog(@"2222222");
        [tableView.mj_header endRefreshing];
        DingCanListBean *dingcanListBean=[DingCanListBean mj_objectWithKeyValues:dict];
        if(dingcanListBean.success==1){
            NSMutableArray *tempArray=[DingCanDetailBean mj_objectArrayWithKeyValuesArray:dingcanListBean.data];
            NSLog(@"333333");
            if(tempArray&&tempArray.count>0){
                self.dingcanArray=tempArray;
                [tableView reloadData];
                 NSLog(@"4444444");
            }
        }
    } Error:^(NSError *err) {
        [tableView.mj_header endRefreshing];
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"网络连接失败"];
    }];
}

- (IBAction)segmentChange:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.zaocanTableView.hidden=NO;
            self.wucanTableView.hidden=YES;
            self.wancanTableView.hidden=YES;
            self.salesStatus=0;
            break;
        case 1:
            self.zaocanTableView.hidden=YES;
            self.wucanTableView.hidden=NO;
            self.wancanTableView.hidden=YES;
             self.salesStatus=1;
            break;
        case 2:
            self.zaocanTableView.hidden=YES;
            self.wucanTableView.hidden=YES;
            self.wancanTableView.hidden=NO;
             self.salesStatus=2;
            break;
        default:
            break;
            
    }
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

-(void)textFieldDidChange:(UITextField *)textField
{
    CGFloat maxLength = 2;
    NSString *toBeString = textField.text;
    
    //获取高亮部分
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    if (!position || !selectedRange)
    {
        if (toBeString.length > maxLength)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxLength];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:maxLength];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}

#pragma mark 加入到菜篮
-(void)addToCaiLan:(NSInteger )count withBean:(DingCanDetailBean *)bean{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    NSString *userId=[userDefault objectForKey:@"userId"];
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"mess/saveInPreOrder.do",apikey];
    NSDictionary *params=@{@"userId":userId,
                           @"disheId":bean.id,
                           @"eatTime":self.eatTime,
                           @"num":[NSString stringWithFormat:@"%ld",count],
                           @"salesStatus":[NSString stringWithFormat:@"%ld",self.salesStatus]
                           };
    [BaseBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
         BaseBean *baseBean=[BaseBean mj_objectWithKeyValues:dict];
        if(baseBean.success==1){
            [MBProgressHUD showError:@"加入菜篮成功"];
            //创建一个消息对象
            NSNotification * notice = [NSNotification notificationWithName:@"cailanRefresh" object:nil];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
        }else{
             [MBProgressHUD showError:@"加入菜篮失败"];
        }
    } Error:^(NSError *err) {
         [MBProgressHUD showError:@"网络连接失败"];
    }];
}
@end
