//
//  SetViewController.m
//  CoffeeBook
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()
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
