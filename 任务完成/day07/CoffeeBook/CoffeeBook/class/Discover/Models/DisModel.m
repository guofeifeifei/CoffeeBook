//
//  DisModel.m
//  CoffeeBook
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "DisModel.h"

@implementation DisModel
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.detail = dict[@"content"];
        self.faceImage = dict[@"face"];
        self.nickname = dict[@"nickname"];
        self.bookImage = dict[@"cover"];
        self.bookName = dict[@"bookname"];
        self.authouName = dict[@"author"];
        self.summer = dict[@"summary"];
        self.goodCount = dict[@"praise"];
        self.tellCount = dict[@"discuss"];
        self.loadTime = dict[@"indate"];
        
    }
    return self;
}
@end
