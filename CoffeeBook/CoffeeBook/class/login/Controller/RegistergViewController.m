//
//  RegistergViewController.m
//  CoffeeBook
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "RegistergViewController.h"
#import "ProgressHUD.h"
#import <BmobSDK/BmobSMS.h>
#import <BmobSDK/BmobUser.h>

@interface RegistergViewController ()<UITextFieldDelegate>


@end

@implementation RegistergViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBackButton];
    self.passworkText.secureTextEntry = YES;
    self.confirmPassword.secureTextEntry = YES;
    
    
    
}
//按return回收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)registerBtn:(id)sender {
    if (![self checkout]) {
        return;
    }
    [ProgressHUD show:@"正在为你注册"];
    BmobUser *bUser = [[BmobUser alloc] init];
    [bUser setEmail:self.emailNuber.text];//转化为小写
    [bUser setUsername:self.phoneNumber.text];
    [bUser setMobilePhoneNumber:self.phoneNumber.text];

    [bUser setPassword:self.passworkText.text];
    [bUser setPassword:self.confirmPassword.text];
    
    //yanzheng
    [BmobSMS verifySMSCodeInBackgroundWithPhoneNumber:self.phoneNumber.text andSMSCode:self.codeNumber.text resultBlock:^(BOOL isSuccessful, NSError *error) {
        
        if (isSuccessful) {
            [bUser signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
                if (isSuccessful) {
                    [ProgressHUD showSuccess:@"注册成功"];
                    
                }else{
                    [ProgressHUD showError:@"注册失败"];
                }
            }];
  
            
    
        }else{
            [ProgressHUD showError:@"注册失败"];
        }
    }];
    

    
}

- (IBAction)requestCodeAction:(id)sender {
    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:self.phoneNumber.text andTemplate:@"test" resultBlock:^(int number, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }else{
            NSLog(@"sms ID:%d", number);
        }
    }];
    
    
    
    
}
//邮箱
- (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
//手机号码验证
- (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
- (BOOL)checkout{

    if (self.phoneNumber) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"亲情提示" message:@"用户名已存在" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        

    }
    
    
    //两次密码不一致
    if (![self.passworkText.text isEqualToString:self.confirmPassword.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"亲情提示" message:@"密码输入不一致" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        
        
        
        return NO;

    }
    //密码一样判断是否为空
    if (self.passworkText.text.length <= 0 || [self.passworkText.text stringByReplacingOccurrencesOfString:@" " withString:@""] <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"亲情提示" message:@"密码不能空" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        return NO;
    }
    if (![self validateMobile:self.phoneNumber.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"亲情提示" message:@"手机号格式不正确" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        return NO;
    }
    if (![self validateEmail:self.emailNuber.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"亲情提示" message:@"邮箱格式不正确" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        return NO;
    }
    
    return YES;
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
