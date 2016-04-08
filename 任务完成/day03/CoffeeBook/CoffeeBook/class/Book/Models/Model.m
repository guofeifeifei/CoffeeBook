//
//  Model.m
//  CoffeeBook
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "Model.h"

@implementation Model
- (instancetype)initWithDiction:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.bookImage = dict[@"titleImageUrl"];
        self.booktitle = dict[@"title"];
        self.subtitle = dict[@"summary"];
        self.typleImage = dict[@"iconUrl"];
        self.typletitle = dict[@"category"];
        self.tell = dict[@"commentCount"];
        self.time = dict[@"publishTime"];
        self.love = dict[@"likeCount"];
    }
    return  self;
}
@end
