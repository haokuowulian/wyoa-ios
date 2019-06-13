//
//  LatestGongGaoDetailViewController.m
//  wyoa
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "LatestGongGaoDetailViewController.h"
#import "NewsUrlBean.h"
#import "Extern.h"
#import "MJExtension.h"
#import "MBProgressHUD+MBProgressHUD.h"
@interface LatestGongGaoDetailViewController ()

@end

@implementation LatestGongGaoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDetail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 获取详情
-(void)getDetail{
    [MBProgressHUD showMessage:@"正在获取公告详情..."];
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *apikey=[userDefault objectForKey:@"apikey"];
    NSString *url=[NSString stringWithFormat:@"%@%@?apikey=%@",baseUrl,@"noteNew/getInfoNewsSort.do",apikey];
    NSDictionary *params=@{@"newsSortId":self.id};
    [NewsUrlBean BeanByPostWithUrl:url Params:params Success:^(NSDictionary *dict) {
        [MBProgressHUD hideHUD];
        NewsUrlBean *resultBean=[NewsUrlBean mj_objectWithKeyValues:dict];
        if(resultBean.success==1){
            NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@?id=%@",resultBean.url,self.id]];
            NSURLRequest *request=[NSURLRequest requestWithURL:url];
            [self.webview loadRequest:request];
        }else{
            [MBProgressHUD showError:resultBean.message];
        }
    } Error:^(NSError *err) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"网络连接失败"];
    }];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *str = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'";
    [self.webview stringByEvaluatingJavaScriptFromString:str];
}


@end
