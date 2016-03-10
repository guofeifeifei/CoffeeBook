//
//  ClassListViewController.m
//  CoffeeBook
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "ClassListViewController.h"
#import "ClassListTableViewCell.h"
#import "BookDetailViewController.h"
#import "BookList.h"
#import "ProgressHUD.h"
#import "MJRefresh.h"
#import <AFNetworking/AFHTTPSessionManager.h>
@interface ClassListViewController ()<UITableViewDataSource, UITableViewDelegate>{
    NSInteger _pagenum;
    BOOL _refresh;
}
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *array;
@property(nonatomic, strong) NSMutableArray *bookIdArray;
@end

@implementation ClassListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _pagenum = 1;
    [self showBackButton];
    self.navigationItem.title = self.stypeTitle;
    self.navigationItem.hidesBackButton = YES;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"ClassListTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self loadData];
    
     [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
         _pagenum = 1;
        
        _refresh = YES;
        [self loadData];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing ];
    }];
   
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _pagenum += 1;
        _refresh = NO;
        [self loadData];
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
    }];
    
    [self swipebackAction];
    
}
- (void)loadData{
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [ProgressHUD show:@"正在加载..."];
    [sessionManager GET:[NSString stringWithFormat:@"%@&pagenum=%ld&ccn=%@", classListJieko, _pagenum, self.ccn] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        NSDictionary *dic = responseObject;
        NSString *message = dic[@"message"];
        if (_refresh) {
            if (self.array.count > 0) {
                [self.array removeAllObjects];
            }
        }
        if ([message isEqualToString:@"ok"]) {
            NSArray *array = dic[@"result"];
            for (NSDictionary *dict in array) {
                BookList *model = [[BookList alloc] initWithDictionary:dict];
                [self.array addObject:model];
                [self.bookIdArray addObject:dict[@"bookid"]];
            }
            
            
            
        }else{
            [ProgressHUD showError:@"网络有误"];
        }
        [ProgressHUD showSuccess:@"加载成功"];
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [ProgressHUD showError:@"网络有误"];
    }];
    
}
#pragma mark --------UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ClassListTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row < self.array.count ){
    cell.model = self.array[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark -------- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BookList *model = [[BookList alloc] init];
    model = self.array[indexPath.row];
    BookDetailViewController *bookDetailVC = [[BookDetailViewController alloc] init];
    bookDetailVC.bookIdstring = self.bookIdArray[indexPath.row];
    bookDetailVC.booName = model.bookName;
    [self.navigationController pushViewController:bookDetailVC animated:YES];
    
}
#pragma mark ------- 懒加载
- (UITableView *)tableView{
    if (_tableView == nil) {
        
        self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 130;
        self.tableView.backgroundColor = kbookColor;
    }
    return _tableView;
}
- (NSMutableArray *)array{
    if (_array == nil) {
        self.array = [NSMutableArray new];
    }
    return _array;
}
- (NSMutableArray *)bookIdArray{
    if (_bookIdArray == nil) {
        self.bookIdArray = [NSMutableArray new];
    }
    return _bookIdArray;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    //self.navigationController.navigationBar.hidden = NO ;
    
    self.tabBarController.tabBar.hidden = NO ;
    [ProgressHUD dismiss];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
  
    
    self.tabBarController.tabBar.hidden = YES;
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
