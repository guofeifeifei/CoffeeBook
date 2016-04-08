//
//  BookClassModel.m
//  CoffeeBook
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "BookClassModel.h"

@implementation BookClassModel
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.className = dict[@"cname"];
        self.classImage = dict[@"cover"];
        self.readNumber = dict[@"count"];
    }
    return self;
}
@end
