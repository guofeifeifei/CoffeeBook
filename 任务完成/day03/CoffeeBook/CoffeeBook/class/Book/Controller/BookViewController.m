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
#import <AFNetworking/AFHTTPSessionManager.h>

@interface BookViewController ()<UITableViewDataSource, UITableViewDelegate, PullingRefreshTableViewDelegate>
@property(nonatomic, strong) NSMutableArray *idArray;
@property(nonatomic, strong) PullingRefreshTableView *tableView;
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
    [self.tableView launchRefreshing];
    [self loadData];
  
    
    
}
#pragma mark -------- UItableVIewDataSouce 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.bookArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BookTableViewCell *bookcell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    bookcell.model = self.bookArray[indexPath.row];
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
//上拉刷新
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    self.refreshing  = NO;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.0];
    NSInteger page = [self.idArray[19] integerValue];
    
    self.maxId = [NSString stringWithFormat:@"%ld", (long)page];
   
    
}
//手指开始拖动方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView tableViewDidScroll:scrollView];
}
//手指结束拖动方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
}
//加载数据{"maxId":"1012","pageSize":"20"}{"maxId":"991","pageSize":"20"}
- (void)loadData{
    
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
//完成加载
    [self.tableView tableViewDidFinishedLoading];
    self.tableView.reachedTheEnd = NO;
}
#pragma mark ------- LazyLoading
- (PullingRefreshTableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 64) pullingDelegate:self];
        
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
