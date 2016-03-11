//
//  RegistergViewController.h
//  CoffeeBook
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistergViewController : UIViewController

//@property (weak, nonatomic) IBOutlet UITextField *securityCode;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;


@property (weak, nonatomic) IBOutlet UITextField *codeNumber;

;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

@property (weak, nonatomic) IBOutlet UITextField *emailNuber;

@property (weak, nonatomic) IBOutlet UITextField *passworkText;

- (BOOL) validateMobile:(NSString *)mobile;
- (BOOL) validateEmail:(NSString *)email;
@end
