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
    // Do any additional setup after loading the view.
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    NSString *idstr = [NSString stringWithFormat:@"%@", self.readId];
    NSDictionary *params = @{@"fragmentId": idstr};
    [sessionManager POST:seeVCJieKo parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.dic = responseObject;
      
        GFFLog(@"%@",self.dic);
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        GFFLog(@"%@",error );
    }];
    

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
