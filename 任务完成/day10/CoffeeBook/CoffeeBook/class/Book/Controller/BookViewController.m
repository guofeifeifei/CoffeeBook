//
//  BookViewController.m
//  CoffeeBook
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "BookViewController.h"
#import "PullingRefreshTableView.h"
#import "BookTableViewCell.h"
#import "ReadViewController.h"
#import "LesionViewController.h"
#import "SeeViewController.h"
#import "Model.h"
#import "ProgressHUD.h"
#import "MJRefresh.h"
#import "ZMYNetManager.h"
#import <AFNetworking/AFHTTPSessionManager.h>

@interface BookViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) NSMutableArray *idArray;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, assign) BOOL refreshing;
@property(nonatomic, strong) NSMutableArray *typeArray;
@property(nonatomic, strong) NSMutableArray *bookArray;
@property(nonatomic, copy) NSString *maxId;//刷新ID
@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.maxId = @"0";
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:@"BookTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
   
    [self loadData];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.refreshing = YES;
      
        self.maxId = @"0";
        [self loadData];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing ];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.refreshing  = NO;
        
        NSInteger page = [self.idArray[19] integerValue];
        
        self.maxId = [NSString stringWithFormat:@"%ld", (long)page];
        
        [self loadData];
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
    }];

    

  
    
    
}
#pragma mark -------- UItableVIewDataSouce 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.bookArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BookTableViewCell *bookcell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row < self.bookArray.count ){
         bookcell.model = self.bookArray[indexPath.row];
    }
   
    bookcell.selectionStyle =  UITableViewCellSelectionStyleNone;
    return bookcell;
    
    
}
#pragma mark ------- UItableViewDelegate
//点击进入
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.typeArray[indexPath.row] > 0) {
        Model *model = [[Model alloc] init];
        model = self.bookArray[indexPath.row];
    switch ([self.typeArray[indexPath.row] integerValue]) {
        case BookListTypeRead:{
            NSLog(@"%ld", BookListTypeRead);//进入看书网页
            ReadViewController *readVC = [[ReadViewController alloc] init];
            readVC.readId = self.idArray[indexPath.row];
            readVC.readType = model.typletitle;
            [self.navigationController pushViewController:readVC animated:YES];
            
        }
            break;
        case BookListTypeLesion:{
            LesionViewController *lesion = [[LesionViewController alloc] init];
            lesion.lesionId = self.idArray[indexPath.row];
            lesion.lesionImage = model.bookImage;
            lesion.lesionType = model.typletitle;
            [self.navigationController pushViewController:lesion animated:YES];
        }
            break;
        case BookListTypeSee:{
            
            NSLog(@"%ld", BookListTypeSee);//进入看视频网页
            
            NSLog(@"%ld", BookListTypeLesion);//进入听书网页
            SeeViewController *seeView = [[SeeViewController alloc] init];
            seeView.seeImage = model.bookImage;
            seeView.seestyle = model.typletitle;
            
            seeView.seeId = self.idArray[indexPath.row];
        
            [self.navigationController pushViewController:seeView animated:YES];
        }

            break;
    }
    }
}

//tableView下拉刷新
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    self.refreshing = YES;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.0];
    self.maxId = @"0";
    
}
- (void)loadData{
    if (![ZMYNetManager shareZMYNetManager].isZMYNetWorkRunning) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您的网络有问题，请检查网络" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           
        }];
        //
        [alert addAction:action];
        [alert addAction:quxiao];
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }
    AFNetworkReachabilityManager *netManager = [AFNetworkReachabilityManager sharedManager];
    [netManager startMonitoring];
    [netManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络链接错误,请检查网络链接" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil]show];
            
            return ;
        }
            
            
        
    }];
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    NSDictionary *params = @{@"sinceId" : @"0", @"pageSize" : @"20", @"maxId": self.maxId};
    [sessionManager POST:bookJieKo parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.refreshing) {
            if (self.bookArray.count > 0) {
                [self.bookArray removeAllObjects];
            }
            if (self.idArray.count > 0) {
                [self.idArray removeAllObjects];
            }
            if (self.typeArray.count > 0) {
                [self.typeArray removeAllObjects];
            }
        }
        
        NSDictionary *dic = responseObject;
        NSArray *array = dic[@"fragments"];
        for (NSDictionary *dict in array) {
        Model *model = [[Model alloc] initWithDiction:dict];
            [self.bookArray addObject:model];
        [ self.idArray addObject:dict[@"id"]];
                   [self.typeArray addObject:dict[@"type"]];
                   
        }
       // NSLog(@"%@", responseObject);
        [self.tableView reloadData];
       
        

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);

    }];

}
#pragma mark ------- LazyLoading
- (UITableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight - 64) ];
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 300;
        self.tableView.backgroundColor = [UIColor colorWithRed:103.0 / 255.0 green:47.0 / 255.0 blue:42.0 / 255.0 alpha:1.0];
        self.tableView.separatorColor = [UIColor whiteColor];
    }
    return _tableView;
}
- (NSMutableArray *)bookArray{
    if (_bookArray == nil) {
        self.bookArray = [NSMutableArray new];
        
    }
    return _bookArray;
    
}
- (NSMutableArray *)idArray{
    if (_idArray == nil) {
        self.idArray = [NSMutableArray new];
    }
    return _idArray;
}
- (NSMutableArray *)typeArray{
    if (_typeArray == nil) {
        self.typeArray = [NSMutableArray new];
        
    }
    return _typeArray;
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];

    [ProgressHUD dismiss];
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
