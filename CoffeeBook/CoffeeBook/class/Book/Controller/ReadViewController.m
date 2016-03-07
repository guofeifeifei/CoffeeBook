//
//  ReadViewController.m
//  CoffeeBook
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "ReadViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
@interface ReadViewController ()
@property(nonatomic, strong) NSDictionary *dic;
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
    
}
- (void)loadData{
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
- (void)loadTextView{
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, kWidth - 40, 44)];
    titleLable.text = self.dic[@"title"];
    titleLable.textColor = kbookColor;
    [self.view addSubview:titleLable];
    
    NSString *htmlStr = self.dic[@"content"];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(20, 70, kWidth - 40, kHeight - 100 - 44 )];
    [webView loadHTMLString:htmlStr baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    //到顶部不可以滑动
    webView.scrollView.bounces = NO;
    //文字适应屏幕
   // webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    
    
    
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
    
    [ProgressHUD dismiss];
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
