//
//  UIViewController+Common.m
//  CoffeeBook
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "UIViewController+Common.h"

@implementation UIViewController (Common)
- (void)swipebackAction{
        UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    recognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:recognizer];

}
- (void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)swipeLeftAction{
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftBack)];
    recognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:recognizer];
    
    
}
- (void)leftBack{
    
    
 
}
- (void)showBackButton{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame  = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"bookclub_toolIcon_back60"] forState:UIControlStateNormal];

    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    [backBtn addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;

}
- (void)backButtonAction:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
