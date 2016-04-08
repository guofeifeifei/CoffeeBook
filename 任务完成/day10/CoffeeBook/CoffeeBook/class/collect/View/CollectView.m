//
//  CollectView.m
//  CoffeeBook
//
//  Created by scjy on 16/3/10.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "CollectView.h"

@implementation CollectView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadingViewCollect];
    }
    return self;
}
- (void)loadingViewCollect{
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth, 1)];
    lable.backgroundColor = [UIColor blackColor];
    [self addSubview:lable];
    self.collectBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.collectBtn.frame = CGRectMake(kWidth - 60, 0, 40, self.frame.size.height );
   
    [self.collectBtn setBackgroundImage:[UIImage imageNamed:@"bookclub_toolIcon_likes60"] forState:UIControlStateNormal];
    [self.collectBtn addTarget:self action:@selector(collectBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.collectBtn];
    
    UIButton *share = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    share.frame = CGRectMake(kWidth - 60 - 50, 0, 40, self.frame.size.height );
    [share setBackgroundImage:[UIImage imageNamed:@"bookclub_toolIcon_share60"] forState:UIControlStateNormal];
   // [share addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:share];
    
    
}
- (void)collectBtnAction{
    NSLog(@"收藏成功");
    [self.collectBtn setBackgroundImage:[UIImage imageNamed:@"bookclub_toolIcon_liked60"] forState:UIControlStateNormal];

}
//- (void)shareAction{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight - 40, kWidth, 40)];
//    [self addSubview:view];
//    self.backgroundColor = [UIColor blackColor];
//    self.alpha =0.0;
//    UIButton *cancle = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    cancle.frame = CGRectMake(kWidth - 60 - 50 , 0, 40, self.frame.size.height );
//    [cancle setTitle:@"取消" forState:UIControlStateNormal];
//    [cancle addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:cancle];
//    
//    UIButton *shareweixin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    shareweixin.frame = CGRectMake(kWidth - 60 - 50 , 0, 40, self.frame.size.height );
//    [shareweixin setBackgroundImage:[UIImage imageNamed:@"UMS_wechat_on"] forState:UIControlStateNormal];
//   // [shareweixin addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:shareweixin];
//    UIButton *shareqq = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    shareqq.frame = CGRectMake(kWidth - 60 - 100, 0, 40, self.frame.size.height );
//    [shareqq setBackgroundImage:[UIImage imageNamed:@"UMS_qq_icon"] forState:UIControlStateNormal];
//    //[shareqq addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:shareqq];
//    UIButton *sharexinlang = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    sharexinlang.frame = CGRectMake(kWidth - 60 - 150, 0, 40, self.frame.size.height );
//    [sharexinlang setBackgroundImage:[UIImage imageNamed:@"sdk_weibo_logo"] forState:UIControlStateNormal];
//    //[sharexinlang addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:sharexinlang];
//    
//    
//}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
