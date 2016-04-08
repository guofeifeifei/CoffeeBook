//
//  Model.h
//  CoffeeBook
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject
@property(nonatomic, copy) NSString *bookImage;//首页大图
@property(nonatomic, copy) NSString *booktitle;//标题
@property(nonatomic, copy) NSString *subtitle;//价格
@property(nonatomic, copy) NSString *typleImage;
@property(nonatomic, copy) NSString *typletitle;//地点
@property(nonatomic, copy) NSString *time;
@property(nonatomic, copy) NSString *tell;
@property(nonatomic, copy) NSString *love;
- (instancetype)initWithDiction:(NSDictionary *)dict;
@end
