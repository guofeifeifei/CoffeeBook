//
//  JieKo.h
//  CoffeeBook
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#ifndef JieKo_h
#define JieKo_h
typedef NS_ENUM(NSInteger, BookListType) {
    
    BookListTypeRead = 1,
    BookListTypeLesion = 2,
    BookListTypeSee = 3,
};

//首页接口
#define bookJieKo @"http://api.dushu.io/fragments"
//视频接口
#define seeVCJieKo @"http://api.dushu.io/fragment/content"

//发现接口
#define discoverJieKo @"http://app.readerday.com/api/auth/authsrv/findlistdata?pagesize=3&pagenum=1&userid=0"
//分类
#define bookClassJieko @"http://app.readerday.com/api/read/readsrv/allccn?"


#endif /* JieKo_h */
