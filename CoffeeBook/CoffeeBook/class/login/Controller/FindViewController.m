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
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:103.0 / 255.0 green:47.0 / 255.0 blue:42.0 /255.0 alpha:1.0], NSFontAttributeName:[UIFont systemFontOfSize:18.0f]}];

}


- (IBAction)anewSet:(id)sender {
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
