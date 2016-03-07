//
//  BookList.m
//  CoffeeBook
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "BookList.h"

@implementation BookList
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.bookImage = dict[@"cover"];
        self.authorName = dict[@"author"];
        self.bookName = dict[@"bookname"];
        self.summary = dict[@"summary"];
    }
    return self;
    
    
}
@end
