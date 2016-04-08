//
//  SeeViewController.m
//  CoffeeBook
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "SeeViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import <SDWebImage/UIImageView+WebCache.h>
@interface SeeViewController ()<UIWebViewDelegate>
{
    int _count;
}
@property(nonatomic, strong) NSMutableDictionary *dic;
@property(nonatomic, strong) MPMoviePlayerController *moviePlayer;
@property(nonatomic, strong) UIProgressView *progressView;
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, strong) UIButton *button;
@property(nonatomic, strong) UIImageView *imageVC;
@end

@implementation SeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarController.tabBar.hidden = YES;
    [self loadData];
    self.title = self.seestyle;
    self.imageVC = [[UIImageView alloc] initWithFrame:CGRectMake(20 , 20 +64, kWidth - 40, 127)];
   
    [self moviewLoading];
    

    [self.imageVC sd_setImageWithURL:[NSURL URLWithString:self.seeImage] placeholderImage:nil];
    [self.view addSubview:self.imageVC];
    
   
   
     
    
}
- (void)moviewLoading{
    //播放
    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.button setFrame:CGRectMake(20, 210, 40, 40)];
    [self.button setBackgroundImage:[UIImage imageNamed:@"bookclub_playerIcon_play128"] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(palyAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setFrame:CGRectMake(kWidth - 60, 210, 40, 40)];
    [btn setTitle:@"全屏" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(fullAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    

    
    NSString *url = [[NSBundle mainBundle] pathForResource:@"Touch_The_Sky" ofType:@".mp4"];
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:url]];
    self.moviePlayer.controlStyle = MPMovieControlStyleNone;
    self.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(MoviewFinishedCallback:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    self.moviePlayer.view.frame = CGRectMake(20 , 20 +64, kWidth - 40, 127);
    [self.moviePlayer setFullscreen:YES];
    [self.view addSubview:self.moviePlayer.view];
    
    
    
    //初始化进度条
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(70, 230, 250, 20)];
    [self.view addSubview:self.progressView];
    self.progressView.progressTintColor = kbookColor;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(playProgress) userInfo:nil repeats:YES];
   
    
    _count = 0;
    
}
- (void)fullAction{
    self.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
//self.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
}
- (void)palyAction{
    if (_count % 2 == 0) {
        //准备播放
        [self.moviePlayer prepareToPlay];
        self.imageVC.hidden = YES;
        [self.button setBackgroundImage:[UIImage imageNamed:@"bookclub_playerIcon_pause128"] forState:UIControlStateNormal];

    }else{
        [self.moviePlayer stop];
        [self.button setBackgroundImage:[UIImage imageNamed:@"bookclub_playerIcon_play128"] forState:UIControlStateNormal];
        self.moviePlayer.currentPlaybackTime = 0;
    }
    _count++;
    
}
- (void)playProgress{
     self.progressView.progress = self.moviePlayer.currentPlaybackTime / self.moviePlayer.duration;
    
}
- (void)MoviewFinishedCallback:(NSNotification *)aNotification{
    MPMoviePlayerController *player = [aNotification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self  name:MPMoviePlayerPlaybackDidFinishNotification object:player];
    [player stop];
    
}
- (void)loadData{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    NSString *idstr = [NSString stringWithFormat:@"%@", self.seeId];
    NSDictionary *params = @{@"fragmentId": idstr};
    [sessionManager POST:seeVCJieKo parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        self.dic = responseObject;
        [self textLodaing];
        //GFFLog(@"%@",self.dic);

        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        GFFLog(@"%@",error );
    }];

    
}

- (void)textLodaing{
    //一个Lable
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(30, 20 + 64 + 127 + 10 + 20,250, 44)];
    titleLable.font = [UIFont systemFontOfSize:15.0];
    titleLable.textColor = kbookColor;
    titleLable.text = self.dic[@"title"];
 //NSLog(@"%@", self.dic[@"title"]);
    [self.view addSubview:titleLable];
    
    //一张图片
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(300, 20 + 64 + 127 + 20 + 20, 40, 70)];
    [image1 sd_setImageWithURL:[NSURL URLWithString:self.dic[@"bookCoverUrl"]] placeholderImage:nil];
    [self.view addSubview:image1];
    //一张图片
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(30, 20 + 64 + 127 + 10 + 44 + 20, 30, 30)];
    [image2 setImage:[UIImage imageNamed:@"60"]];
    [self.view addSubview:image2];
    
    
    NSString *htmlstr = self.dic[@"content"];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(20, 300 + 50, kWidth - 40, kHeight - 300 - 100)];
    webView.delegate = self;
   
    [webView loadHTMLString:htmlstr baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath] ]];
    [self.view addSubview:webView];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSMutableDictionary *)dic{
    if (_dic == nil) {
        self.dic = [NSMutableDictionary new];
    }
    return _dic;
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
