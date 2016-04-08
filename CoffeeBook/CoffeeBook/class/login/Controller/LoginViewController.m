//
//  LoginViewController.m
//  CoffeeBook
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "LoginViewController.h"
#import <BmobSDK/BmobUser.h>
#import "ProgressHUD.h"
@interface LoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UITextField *passWordText;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBackButton];
    self.passWordText.secureTextEntry = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:103.0 / 255.0 green:47.0 / 255.0 blue:42.0 /255.0 alpha:1.0], NSFontAttributeName:[UIFont systemFontOfSize:18.0f]}];

    
}

- (IBAction)loginAction:(id)sender {
    [BmobUser loginWithUsernameInBackground:self.userNameText.text password:self.passWordText.text block:^(BmobUser *user, NSError *error) {
        if (user) {
            [ProgressHUD showSuccess:@"登陆成功"];
           
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeImage" object:nil userInfo:@{@"input" : @"headimage1.jpg"}];
 [self.navigationController popViewControllerAnimated:YES];
           
        }else{
            [ProgressHUD showSuccess:@"登录失败"];
        }
    }];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
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
