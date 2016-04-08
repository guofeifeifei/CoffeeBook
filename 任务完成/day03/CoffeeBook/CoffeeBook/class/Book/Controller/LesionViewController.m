//
//  LesionViewController.m
//  CoffeeBook
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "LesionViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import <SDWebImage/UIImageView+WebCache.h>
@interface LesionViewController (){
    NSInteger _count;
}
@property(nonatomic, strong) NSDictionary *dic;
@property(nonatomic, strong) AVAudioPlayer *avAudioPlayer;
@property(nonatomic, strong) UIProgressView *progressView;
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, strong) UIButton *button;
@end

@implementation LesionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationItem.title = self.lesionType;
     UIImageView *imageVC = [[UIImageView alloc] initWithFrame:CGRectMake(20 , 20 +64, kWidth - 40, 127)];
    [imageVC sd_setImageWithURL:[NSURL URLWithString:self.lesionImage] placeholderImage:nil];
    [self.view addSubview:imageVC];
    }
- (void)moviewLoading{
    //播放
    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.button setFrame:CGRectMake(20, 210, 40, 40)];
    [self.button setBackgroundImage:[UIImage imageNamed:@"bookclub_playerIcon_play128"] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    _count = 0;
    

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
    [self.avAudioPlayer prepareToPlay];
    
    //初始化进度条
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(70, 230, 250, 20)];
    [self.view addSubview:self.progressView];
    self.progressView.progressTintColor = kbookColor;
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
        AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
        sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        NSString *idstr = [NSString stringWithFormat:@"%@", self.lesionId];
        NSDictionary *params = @{@"fragmentId": idstr};
        [sessionManager POST:seeVCJieKo parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            self.dic = responseObject;
                        GFFLog(@"%@",self.dic);
            
            [self moviewLoading];
            [self textLodaing];

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
    NSLog(@"%@", self.dic[@"title"]);
    [self.view addSubview:titleLable];
    
    //一张图片
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(300, 20 + 64 + 127 + 20 + 20, 40, 70)];
    [image1 sd_setImageWithURL:[NSURL URLWithString:self.dic[@"bookCoverUrl"]] placeholderImage:nil];
    [self.view addSubview:image1];
    //一张图片
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(30, 20 + 64 + 127 + 10 + 44 + 20, 30, 30)];
    [image2 setImage:[UIImage imageNamed:@"60"]];
    [self.view addSubview:image2];
    
    NSString *htmlStr = self.dic[@"content"];
    
     UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(20, 300 + 50, kWidth - 40, kHeight - 300 - 100 )];
    [webView loadHTMLString:htmlStr baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
