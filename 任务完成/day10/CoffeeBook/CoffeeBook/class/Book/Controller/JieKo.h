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
//http://app.readerday.com/api/auth/authsrv/findlistdata?pagesize=3&pagenum=1&userid=0
//http://app.readerday.com/api/auth/authsrv/friendpersonal?userid=34410
//发现接口
#define discoverJieKo @"http://app.readerday.com/api/auth/authsrv/findlistdata?pagesize=3&userid=0"
//分类
#define bookClassJieko @"http://app.readerday.com/api/read/readsrv/allccn?"
//图片接口
#define imageJieko @"http://img.readerday.com/cover/"
//用户接口
#define userJieKo @"http://app.readerday.com/api/auth/authsrv/friendpersonal?"

//分类音频界面
#define lessionJieko @"http://app.readerday.com/api/read/readsrv/bookindex?pagesize=10&pagenum=1&userid=0"
//分类进入页面
#define classListJieko @"http://app.readerday.com/api/read/readsrv/ccnbook?pagesize=10"
//进入书
#define bookdetailJieko @"http://app.readerday.com/api/read/readsrv/booknewdigests?pagesize=5&pagenum=1&userid=0"
#define kBmobAppKey @"02133eab46c755ee1bf1067fcc9c17d1"
#endif /* JieKo_h */
