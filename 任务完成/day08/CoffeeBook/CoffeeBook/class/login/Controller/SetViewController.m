//
//  SetViewController.m
//  CoffeeBook
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "SetViewController.h"
#import "ProgressHUD.h"
#import <MessageUI/MessageUI.h>
#import <SDWebImage/SDImageCache.h>
@interface SetViewController ()<MFMailComposeViewControllerDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *cleanMemoryLable;

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBackButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO;
    
}

- (IBAction)userLable:(id)sender {
    
}

- (IBAction)collection:(id)sender {
    
}
- (IBAction)clearnMemoryBtn:(id)sender {
    [ProgressHUD show:@"正在为你清理中"];
    [self performSelector:@selector(cleanAction) withObject:nil afterDelay:5.0];
}
- (IBAction)userFeedBack:(id)sender {
    [self sendEmail];
}
- (IBAction)aboutCoffeeBook:(id)sender {
    
    [ProgressHUD show:@"正在为你检测"];
    [self performSelector:@selector(checkAppVersion) withObject:nil afterDelay:2.0];
    
}
- (void)checkAppVersion{
     [ProgressHUD showSuccess:@"当前已是最新版本"];
    
}
- (void)sendEmail{
    Class mailClass = NSClassFromString(@"MFMailComposeViewController");
    if (mailClass != nil) {
        if ([MFMailComposeViewController canSendMail]) {
            MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
            picker.mailComposeDelegate = self;
            [picker setSubject:@"用户反馈"];
            NSArray *receiveArray = [NSArray arrayWithObjects:@"2545706530@qq.com", nil];
            [picker setToRecipients:receiveArray];
            NSString *text = @"请留下你宝贵的意见";
            [picker setMessageBody:text isHTML:YES];
            [self presentViewController:picker animated:YES completion:nil];
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"未配置邮箱" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            alert.delegate = self;
            [alert show];
        }
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"当前设备不能发送邮件" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}
//发送邮箱完成调用此方法
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"取消发送");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"保存邮件");
            break;
        case MFMailComposeResultSent:{
            NSLog(@"发送邮件");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"邮件发送成功" message:@"邮件发送成功，谢谢您的宝贵意见，我将认真改进" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            alert.delegate = self;
            [alert show];

        } break;
        case MFMailComposeResultFailed:
            NSLog(@"发送失败");
            break;
            
        default:
            break;
    }
    
}
- (void)cleanAction{
    [ProgressHUD show:@"清理干净"];
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    [imageCache cleanDisk];
    self.cleanMemoryLable.text = @"0.0";
    [ProgressHUD dismiss];
    
    
}
//返回页面
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
    SDImageCache *cache = [SDImageCache sharedImageCache];
    NSInteger cachesize = [cache getSize];
    NSLog(@"缓存%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES));
    NSString *cacheStr = [NSString stringWithFormat:@"清除缓存(%.02f)M", (float)cachesize / 1024 / 1024];
    self.cleanMemoryLable.text = cacheStr;
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
