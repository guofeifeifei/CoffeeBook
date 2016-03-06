//
//  DiscoverViewController.m
//  CoffeeBook
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "DiscoverViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
@interface DiscoverViewController ()
//{
//"fragmentId": "1028"
//}
@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //http://app.readerday.com/api/auth/authsrv/findlistdata?pagesize=3&pagenum=1&userid=33040
    //http://app.readerday.com/api/read/readsrv/booknewdigests?pagesize=5&pagenum=1&userid=33040&bookid=12842
    //http://app.readerday.com/api/auth/authsrv/findlistdata?pagesize=3&pagenum=1&userid=0
    //http://app.readerday.com/api/auth/authsrv/findlistdata?pagesize=3&pagenum=1&userid=33040&cover=978780087938817.png
    
    
    //http://img.readerday.com/cover/978751434066213.mp3
    [self loadData];
}
- (void)loadData{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [sessionManager GET:discoverJieKo parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
 
    
    
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.hidden = YES;
    
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = NO;
    
    self.tabBarController.tabBar.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
