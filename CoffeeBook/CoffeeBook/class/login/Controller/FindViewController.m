//
//  FindViewController.m
//  CoffeeBook
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "FindViewController.h"
#import <BmobSDK/BmobSMS.h>
#import <BmobSDK/BmobUser.h>
#import "ProgressHUD.h"
@interface FindViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;


@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBackButton];
}
//- (IBAction)sendCode:(id)sender {
//    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:self.phoneNumber.text andTemplate:@"test" resultBlock:^(int number, NSError *error) {
//        if (error) {
//            NSLog(@"%@", error);
//        }else{
//            NSLog(@"sms ID:%d", number);
//            
//            
//        }
//    }];
//    
//    
//}
- (IBAction)anewSet:(id)sender {
//    [BmobUser resetPasswordInbackgroundWithSMSCode:self.codeNmber.text andNewPassword:self.confirmPassword.text block:^(BOOL isSuccessful, NSError *error) {
//        if (isSuccessful) {
//            [ProgressHUD showSuccess:@"密码设置成功"];
//        }else{
//            [ProgressHUD showError:@"密码设置错误"];
//        }
//    }];
    
    BmobUser *user = [BmobUser getCurrentUser];
    if ([user objectForKey:@"emailVerified"]) {
        if (![[user objectForKey:@"emailVerified"]boolValue]) {
            [user verifyEmailInBackgroundWithEmailAddress:self.phoneNumber.text];
            [BmobUser requestPasswordResetInBackgroundWithEmail:self.phoneNumber.text];
        }
    }
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
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
