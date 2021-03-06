//
//  DiscoverViewController.m
//  CoffeeBook
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "DiscoverViewController.h"
#import "DisListTableViewCell.h"
#import "DisModel.h"
#import "BookDetailViewController.h"
#import "ProgressHUD.h"
#import "MJRefresh.h"
#import <AFNetworking/AFHTTPSessionManager.h>
@interface DiscoverViewController ()<UITableViewDataSource, UITableViewDelegate>{
    NSInteger _pageNum;
    BOOL _refresh;
    NSString *_title;
    NSString *_id;
}
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSString *bookTitle;
@property(nonatomic, strong) NSString *bookid;
@property(nonatomic, strong) NSMutableArray *bookNameArray;
@property(nonatomic, strong) NSMutableArray *array;
@property(nonatomic, strong) NSMutableArray *idArray;
//{
//"fragmentId": "1028"
//}
@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageNum = 1;
    self.bookTitle = @"";
    self.bookid = @"";
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:@"DisListTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
     [self loadData];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _refresh = YES;
        _pageNum = 1;
        [self loadData];
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing ];
    }];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        _refresh = NO;
        _pageNum += 1;
        [self loadData];
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
    
}
- (void)loadData{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [ProgressHUD show:@"正在加载..."];
    [sessionManager GET:discoverJieKo parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSDictionary *dic = responseObject;
        NSString *message = dic[@"message"];
        if (_refresh) {
            if (self.array.count > 0) {
                [self.array removeAllObjects];
            }
        }
        if ([message isEqualToString:@"查询成功！"]) {
            NSArray *array = dic[@"result"];
            for (NSDictionary *dict in array) {
                DisModel *model = [[DisModel alloc] initWithDictionary:dict];
            
                [self.array addObject:model];
                [self.idArray addObject:dict[@"bookid"]];
                [self.bookNameArray addObject:dict[@"bookname"]];
            }
            NSLog(@"%@", self.array);
            
            [ProgressHUD showSuccess:@"加载完成"];
        }else{
            [ProgressHUD show:@"网络有误"];

        }
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        [ProgressHUD show:@"网络有误"];
    }];
 
    
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DisListTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //补上的几句，给用来显示的DetailLabel 设置最大布局宽度
    CGFloat preMaxWaith =[UIScreen mainScreen].bounds.size.width;
    
    [cell.detailLable setPreferredMaxLayoutWidth:preMaxWaith];
    [cell.detailLable layoutIfNeeded];

    //  [cell.detailLable setText:nil];
//        [cell.detailLable setText:[self.descriptionArray objectAtIndex:indexPath.row]];
    if (indexPath.row < self.array.count) {
        cell.model = self.array[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.nickname addTarget:self action:@selector(userAction) forControlEvents:UIControlEventTouchUpInside];
    [cell.BookDetailButton addTarget:self action:@selector(bookAction) forControlEvents:UIControlEventTouchUpInside];
    self.bookid = self.idArray[indexPath.row];
    self.bookTitle = self.bookNameArray[indexPath.row];
    return cell;
}
- (void)userAction{
    
}
- (void)bookAction {
   
    
    BookDetailViewController *bookDetailVC = [BookDetailViewController alloc];
    bookDetailVC.bookIdstring = [NSString stringWithFormat:@"%@", self.bookid];
    bookDetailVC.booName = self.bookTitle;
    [self.navigationController pushViewController:bookDetailVC animated:YES];
    
    
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
       // self.tableView.separatorColor = [UIColor whiteColor];
      // self.tableView.rowHeight = 216;
        
    }
    return _tableView;
    
}

//高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DisModel *model = [[DisModel alloc] init];
    model = self.array[indexPath.row];
    static DisListTableViewCell *cell = nil;
    static dispatch_once_t onceToken;
    //只会走一次
    dispatch_once(&onceToken, ^{
        cell = (DisListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    });
    CGFloat height = [cell calulateHeightWithTitle:model.nickname desip:model.detail];
    
    return height;
    
    
    
    
}
- (NSMutableArray *)array{
    if (_array == nil) {
        self.array = [NSMutableArray new];
    }
    return _array;
    
    
}
- (NSMutableArray *)idArray{
    if (_idArray == nil) {
        self.idArray = [NSMutableArray new];
    }
    return _idArray;
    
    
    
}
- (NSMutableArray *)bookNameArray{
    if (_bookNameArray == nil) {
        _bookNameArray = [NSMutableArray new];
    }
    return _bookNameArray;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.hidden = YES;
    
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = NO;
    
    self.tabBarController.tabBar.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
