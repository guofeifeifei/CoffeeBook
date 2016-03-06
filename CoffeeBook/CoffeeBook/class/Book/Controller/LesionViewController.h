//
//  LesionViewController.h
//  CoffeeBook
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface LesionViewController : UIViewController<AVAudioPlayerDelegate>
@property(nonatomic, copy) NSString *lesionId;
@property(nonatomic, copy) NSString *lesionImage;
@property(nonatomic, copy) NSString *lesionType;
@end
