//
//  DisModel.h
//  CoffeeBook
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DisModel : NSObject
@property(nonatomic, copy) NSString *detail;
@property(nonatomic, copy) NSString *faceImage;
@property(nonatomic, copy) NSString *nickname;
@property(nonatomic, copy) NSString *bookImage;
@property(nonatomic, copy) NSString *bookName;
@property(nonatomic, copy) NSString *authouName;
@property(nonatomic, copy) NSString *summer;
@property(nonatomic, copy) NSString *goodCount;
@property(nonatomic, copy) NSString *tellCount;
@property(nonatomic, copy) NSString *loadTime;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
