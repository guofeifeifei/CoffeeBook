//
//  ReadViewController.m
//  CoffeeBook
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "ReadViewController.h"
#import "ProgressHUD.h"
#import "CollectView.h"
#import "ZMYNetManager.h"

#import <AFNetworking/AFHTTPSessionManager.h>
@interface ReadViewController ()<UIWebViewDelegate>
@property(nonatomic, strong) NSDictionary *dic;
@property(nonatomic, strong) UIActivityIndicatorView *activity;
@property(nonatomic, strong) UIWebView *webView;
@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    //手势返回上一页
    [self swipebackAction];
    self.title = self.readType;
    [self loadData];
    CollectView *collectView = [[CollectView alloc] initWithFrame:CGRectMake(0, kHeight - 40, kWidth, 40)];
    [self.view addSubview:collectView];
    [self.view addSubview:self.activity];
}
- (void)loadData{
    if (![ZMYNetManager shareZMYNetManager].isZMYNetWorkRunning) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您的网络有问题，请检查网络" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          
        }];
        UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           
        }];
        //
        [alert addAction:action];
        [alert addAction:quxiao];
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }else{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    NSString *idstr = [NSString stringWithFormat:@"%@", self.readId];
    NSDictionary *pamars = @{@"fragmentId" : idstr};
     [ProgressHUD show:@"正在加载中"];
    [sessionManager POST:seeVCJieKo parameters:pamars progress:^(NSProgress * _Nonnull uploadProgress) {
       
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@", responseObject);
        self.dic = responseObject;
        [self loadTextView];
        
        [ProgressHUD showSuccess:@"加载完成"];
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        [ProgressHUD showError:@"网络有误"];
    }];
    
    }
    
}
- (void)loadTextView{
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, kWidth - 40, 44)];
    titleLable.text = self.dic[@"title"];
    titleLable.textColor = kbookColor;
    [self.view addSubview:titleLable];
    
 
    [self.view addSubview:self.webView];
    
    
    
    
}
- (UIWebView *)webView{
    if (_webView == nil) {
        NSString *htmlStr = self.dic[@"content"];
       self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(20, 70, kWidth - 40, kHeight - 100 - 44 )];
        [self.webView loadHTMLString:htmlStr baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
        self.webView.delegate = self;
        //到顶部不可以滑动
        self.webView.scrollView.bounces = NO;
        //文字适应屏幕
        // webView.scalesPageToFit = YES;
    }
    return _webView;
    
}
- (UIActivityIndicatorView *)activity{
    if (_activity == nil) {
        self.activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.activity.backgroundColor = kbookColor;
        //显示位置
        self.activity.center = self.view.center;
        //
        // [self.activity startAnimating];
        
       
        
    }
    return _activity;
    
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.activity startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.activity stopAnimating];
    
}
- (NSDictionary *)dic{
    if (_dic == nil) {
        self.dic = [NSDictionary new];
    }
    return _dic;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.hidden = NO ;
    
    self.tabBarController.tabBar.hidden = NO ;
    [ProgressHUD dismiss];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
    
    self.tabBarController.tabBar.hidden = YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
