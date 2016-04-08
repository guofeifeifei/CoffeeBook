//
//  BookDetailViewController.m
//  CoffeeBook
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "BookDetailViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "ProgressHUD.h"
#import "MJRefresh.h"
#import "CollectView.h"
#import "ZMYNetManager.h"
@interface BookDetailViewController ()<AVAudioPlayerDelegate>{
    NSInteger _count;
}
@property(nonatomic, strong) NSDictionary *detailedDic;
@property(nonatomic, strong) NSDictionary *digestsDic;
@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, strong) AVAudioPlayer *audioPlayer;
@property(nonatomic, strong) UIButton *button;
@property(nonatomic, strong) UIImageView *bookImageView;
@end

@implementation BookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self showBackButton];
    // Do any additional setup after loading the view.
    [self swipebackAction];
    _count = 0;
    self.title = self.booName;
//    self.navigationItem.hidesBackButton = YES;
    [self loadData];
    CollectView *collectView = [[CollectView alloc] initWithFrame:CGRectMake(0, kHeight - 40, kWidth, 40)];
    [self.view addSubview:collectView];
    
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
        
        
    }
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [ProgressHUD show:@"开始加载"];
    [sessionManager GET:[NSString stringWithFormat:@"%@&bookid=%@", bookdetailJieko, self.bookIdstring] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        [ProgressHUD show:@"正在加载"];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          NSLog(@"%@", responseObject);
        NSDictionary *dic = responseObject;
        NSString *message  = dic[@"message"];
        if ([message isEqualToString:@"ok"]) {
            NSDictionary *resultDic = dic[@"result"];
            self.detailedDic = resultDic[@"detailed"];
            NSLog(@"%@", self.detailedDic);
            NSArray *array = [NSArray new];
            array = resultDic[@"digests"];
            NSLog(@"%@", resultDic[@"digests"]);
            if (array.count > 0) {
                self.digestsDic = array[0];
            }
           
            [self.view addSubview:self.webView];
[ProgressHUD showSuccess:@"加载完成"];
        }else{
            [ProgressHUD show:@"网络有误"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ProgressHUD showError:@"网络有误"];
        
    }];
    
    NSLog(@"%@",self.bookIdstring);
    
    
    
}
- (NSDictionary *)detailedDic{
    if (_detailedDic == nil) {
        self.detailedDic = [NSDictionary new];
    }
    return _detailedDic;
}
- (NSDictionary *)digestsDic{
    if (_digestsDic == nil) {
         self.digestsDic = [NSDictionary new];
    }
    return _digestsDic;
    
}
- (UIWebView *)webView{
    if (_webView == nil) {
        
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(10,50, kWidth - 20, kHeight - 50 - 50 )];
        self.webView.backgroundColor = [UIColor whiteColor];
        self.webView.scrollView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
        self.webView.scrollView.backgroundColor = [UIColor whiteColor];
        
        [self.webView.scrollView addSubview:self.bookImageView];
        
        self.webView.opaque = NO;
        
   
        NSString *urlstr = self.digestsDic[@"content"];
        [self.webView loadHTMLString:urlstr baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath] ]];
        
        self.webView.scrollView.bounces = NO;
//        //判断是否有音频
//        NSString *vistring = self.detailedDic[@"bookvideo"];
//        NSLog(@"%@", vistring);
//        if (![vistring isEqualToString:@""] || ![vistring isEqualToString:@" "] || ![vistring isEqualToString:@"null"]) {
////            [vistring isKindOfClass:[NSNull class]];
//            [self.audioPlayer prepareToPlay];
//            [self.webView.scrollView addSubview:self.button];
//            
//        }
//        NSLog(@"bookvideo = %@", self.detailedDic[@"bookvideo"]);
    }
    return _webView;
}

- (UIImageView *)bookImageView{
    if (_bookImageView == nil) {
        self.bookImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth/2 - 50, -180, 100, 150)];
        
        NSString *urlstring = [NSString stringWithFormat:@"%@%@",imageJieko, self.detailedDic[@"cover"]];
        [self.bookImageView sd_setImageWithURL:[NSURL URLWithString:urlstring] ];
        

    }
    return _bookImageView;
}
- (AVAudioPlayer *)audioPlayer{
    if (_audioPlayer == nil) {
        //获取音频
        NSArray *array = [NSArray new];
        array =  self.detailedDic[@"bookvideo"];
       
           NSString *urlStr = array[0];

        NSLog(@"%@", urlStr);
        
        NSURL *url = [[NSURL alloc] initWithString:urlStr];
        NSData *audioData = [NSData dataWithContentsOfURL:url];
        NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3", docDirPath, @"temp"];
        [audioData writeToFile:filePath atomically:YES];
        NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:nil];
        self.audioPlayer.delegate = self;
    }
    return _audioPlayer;
}
- (UIButton *)button{
    if (_button == nil) {
        self.button  = [[UIButton alloc] initWithFrame:CGRectMake(kWidth / 2 - 20, -115, 40, 40)];
        [self.button setBackgroundImage:[UIImage imageNamed:@"bookclub_playerIcon_play128"] forState:UIControlStateNormal];
        [self.button addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}
- (void)play{
    
    if (_count % 2 == 0) {
        [self.audioPlayer play];
        [self.button setBackgroundImage:[UIImage imageNamed:@"bookclub_playerIcon_pause128"] forState:UIControlStateNormal];
        
    }else{
        [self.button setBackgroundImage:[UIImage imageNamed:@"bookclub_playerIcon_play128"] forState:UIControlStateNormal];
        [self.audioPlayer stop];
    }
    
    _count ++;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO;
    [ProgressHUD dismiss];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
   
    self.tabBarController.tabBar.hidden = YES;

    

    
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
