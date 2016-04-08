//
//  BookClassModel.h
//  CoffeeBook
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookClassModel : NSObject
@property(nonatomic, copy) NSString *className;
@property(nonatomic, copy) NSString *classImage;
@property(nonatomic, copy) NSString *readNumber;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
