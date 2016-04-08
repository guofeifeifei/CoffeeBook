//
//  LesionViewController.m
//  CoffeeBook
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "LesionViewController.h"
#import "ProgressHUD.h"
#import "CollectView.h"
#import "ZMYNetManager.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import <SDWebImage/UIImageView+WebCache.h>
@interface LesionViewController ()<UIWebViewDelegate>{
    NSInteger _count;
}
@property(nonatomic, strong) NSDictionary *dic;
@property(nonatomic, strong) AVAudioPlayer *avAudioPlayer;
@property(nonatomic, strong) UIProgressView *progressView;
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, strong) UIButton *button;
@property(nonatomic, strong) UILabel *titleLable;
@property(nonatomic, strong) UIImageView *image1;
@property(nonatomic, strong) UIImageView *image2;
@property(nonatomic, strong) UIWebView *webView;
  @property(nonatomic, strong) UIActivityIndicatorView *activity;
@end

@implementation LesionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self loadData];
    //手势返回上一页
    [self swipebackAction];
   
    
     UIImageView *imageVC = [[UIImageView alloc] initWithFrame:CGRectMake(20 , 20 +64 + 50, kWidth - 40, 127)];
    [imageVC sd_setImageWithURL:[NSURL URLWithString:self.lesionImage] placeholderImage:nil];
    [self.view addSubview:imageVC];
    CollectView *collectView = [[CollectView alloc] initWithFrame:CGRectMake(0, kHeight - 40, kWidth, 40)];
    [self.view addSubview:collectView];
    [self.view addSubview:self.activity];
    }
- (void)moviewLoading{
   
    [self.view addSubview:self.button];
    _count = 0;
    

   
    [self.avAudioPlayer prepareToPlay];
    
   
    [self.view addSubview:self.progressView];
   
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(playProgress) userInfo:nil repeats:YES];
    
    
}

- (void)play{
    
    if (_count % 2 == 0) {
        [self.avAudioPlayer play];
        [self.button setBackgroundImage:[UIImage imageNamed:@"bookclub_playerIcon_pause128"] forState:UIControlStateNormal];

    }else{
        [self.button setBackgroundImage:[UIImage imageNamed:@"bookclub_playerIcon_play128"] forState:UIControlStateNormal];
        self.avAudioPlayer.currentTime = 0;
        [self.avAudioPlayer stop];
    }
   
    _count ++;
}

- (void)playProgress{
    self.progressView.progress = self.avAudioPlayer.currentTime/self.avAudioPlayer.duration;
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
        NSString *idstr = [NSString stringWithFormat:@"%@", self.lesionId];
        NSDictionary *params = @{@"fragmentId": idstr};
       [ProgressHUD show:@"正在加载..."];
        [sessionManager POST:seeVCJieKo parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
         
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           
            self.dic = responseObject;
                        GFFLog(@"%@",self.dic);
            
            [self moviewLoading];
            [self textLodaing];
             [ProgressHUD showSuccess:@"加载完成"];

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [ProgressHUD showError:@"网络有误"];
            GFFLog(@"%@",error );
        }];
        
        
    }
}
- (void)textLodaing{
      [self.view addSubview:self.titleLable];
    
       [self.view addSubview:self.image1];
   
    [self.view addSubview:self.image2];
    
   
    [self.view addSubview:self.webView ];
      
    
    
    
}
- (UIActivityIndicatorView *)activity{
    if (_activity == nil) {
        self.activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.activity.backgroundColor = kbookColor;
        //显示位置
        self.activity.center = self.view.center;

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
- (UILabel *)titleLable{
    if (_titleLable == nil) {
        //一个Lable
       self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 30 ,240, 44)];
        self.titleLable.textColor = kbookColor;
        self.titleLable.text = self.dic[@"title"];
        NSLog(@"%@", self.dic[@"title"]);

    }
    return _titleLable;
}
- (UIImageView *)image1{
    if (_image1 == nil) {
        //一张图片
        self.image1 = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth - 60, 40, 40, 70)];
        [self.image1 sd_setImageWithURL:[NSURL URLWithString:self.dic[@"bookCoverUrl"]] placeholderImage:nil];

    }
    return _image1;
}
- (UIImageView *)image2{
    if (_image2 == nil) {
        //一张图片
        self.image2 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 30 + 44, 30, 30)];
        [self.image2 setImage:[UIImage imageNamed:@"60"]];
    }
    return _image2;
}
- (UIWebView *)webView{
    if (_webView == nil) {
        NSString *htmlStr = self.dic[@"content"];
        
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(20, 300 , kWidth - 40, kHeight - 300 - 50 )];
        [self.webView  loadHTMLString:htmlStr baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
        //到顶部不可以滑动
        self.webView .scrollView.bounces = NO;
        self.webView.delegate = self;
    }
    return _webView;
}

- (UIButton *)button{
    if (_button == nil) {
        //播放
        self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.button setFrame:CGRectMake(20, 210 + 50, 40, 40)];
        [self.button setBackgroundImage:[UIImage imageNamed:@"bookclub_playerIcon_play128"] forState:UIControlStateNormal];
        [self.button addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _button;
}
- (AVAudioPlayer *)avAudioPlayer{
    if (_avAudioPlayer == nil) {
        //获取音频
        NSArray *array = [NSArray new];
        array = self.dic[@"mediaUrls"];
        NSString *urlStr = array[0];
        NSURL *url = [[NSURL alloc] initWithString:urlStr];
        NSData *audioData = [NSData dataWithContentsOfURL:url];
        NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3", docDirPath,@"temp"];
        [audioData writeToFile:filePath atomically:YES];
        NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
        
        self.avAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:nil];
        self.avAudioPlayer.delegate = self;
        
    }
    return _avAudioPlayer;
}
- (UIProgressView *)progressView{
    if (_progressView == nil) {
        //初始化进度条
        self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(70, 230 + 50, 250, 20)];
        self.progressView.progressTintColor = kbookColor;
    }
    return _progressView;
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
