//
//  BookList.h
//  CoffeeBook
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookList : NSObject
@property(nonatomic, copy) NSString *bookName;
@property(nonatomic, copy) NSString *authorName;
@property(nonatomic, copy) NSString *bookImage;
@property(nonatomic, copy) NSString *summary;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
