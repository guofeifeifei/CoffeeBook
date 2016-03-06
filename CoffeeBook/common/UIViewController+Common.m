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
@end
