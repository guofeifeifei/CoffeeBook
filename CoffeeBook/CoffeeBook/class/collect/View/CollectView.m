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
    
    
    
    
}
- (void)collectBtnAction{
    NSLog(@"收藏成功");
    [self.collectBtn setBackgroundImage:[UIImage imageNamed:@"bookclub_toolIcon_liked60"] forState:UIControlStateNormal];
    
    
    
    
    
    
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
