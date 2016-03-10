//
//  BookClassViewController.m
//  CoffeeBook
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "BookClassViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "BookClassCollectionViewCell.h"
#import "BookClassModel.h"
#import "ProgressHUD.h"
#import "MJRefresh.h"
#import "SetViewController.h"
#import "ClassListViewController.h"
@interface BookClassViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) NSMutableArray *array;
@property(nonatomic, strong) NSMutableArray *arrayccn;
@property(nonatomic, strong) UICollectionView *collection;
@end

@implementation BookClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    [self.view addSubview:self.collection];
    [self.collection.mj_header beginRefreshing];
    
    self.collection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self.collection reloadData];
        [self loadData];
        // 结束刷新
        [self.collection.mj_header endRefreshing];
    }];
    self.collection.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.collection reloadData];
        
        // 结束刷新
        [self.collection.mj_header endRefreshing];
    }];
    [self swipebackAction];
}


- (void)loadData{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [sessionManager GET:bookClassJieko parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
       // [ProgressHUD show:@"正在加载..."];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       // NSLog(@"%@", responseObject);
        NSDictionary *dic = responseObject;
        NSString *message = dic[@"message"];
        
        if ([message isEqualToString:@"ok"]) {
            NSArray *array = dic[@"result"];
            for (NSDictionary *dict in array) {
                BookClassModel *model = [[BookClassModel alloc] initWithDictionary:dict];
                [self.array addObject:model];
                [self.arrayccn addObject:dict[@"typeccn"]];
            }
          //  NSLog(@"%@", dic);
            
        }else{
           // [ProgressHUD showError:@"网络有误"];
            
            
            
          
        }
        
        [self.collection reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
}
#pragma mark ------- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   
    return self.array.count ;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UINib *nib = [UINib nibWithNibName:@"BookClassCollectionViewCell" bundle: [NSBundle mainBundle]];
       [collectionView registerNib:nib forCellWithReuseIdentifier:@"itemIdentifier"];
    
    BookClassCollectionViewCell *cell = [[BookClassCollectionViewCell alloc] init];
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"itemIdentifier" forIndexPath:indexPath];
      if (indexPath.row < self.array.count ) {
         
    cell.model = self.array[indexPath.row];
          
    }
    return cell;
    
    
    
}
//点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    BookClassModel *model = [[BookClassModel alloc] init];
    model = self.array[indexPath.row];
    ClassListViewController *classListVC = [[ClassListViewController alloc] init];
    classListVC.ccn = self.arrayccn[indexPath.row];
    classListVC.stypeTitle = model.className;
    [self.navigationController pushViewController:classListVC animated:YES];
    
}
- (UICollectionView *)collection{
    if (_collection == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(kWidth / 2 - 10, 130);
        self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight - 64) collectionViewLayout:layout];
        self.collection.delegate = self;
        self.collection.dataSource = self;
        //行间距
        layout.minimumLineSpacing = 5;
        //section的边距
        layout.minimumInteritemSpacing = 10;
        //section的边距
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        
        self.collection.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:235/ 255.0 blue:241/ 255.0 alpha:1.0];

    }
    return _collection;
}

- (NSMutableArray *)array{
    if (_array == nil) {
        self.array = [NSMutableArray new];
    }
    return _array;
}
- (NSMutableArray *)arrayccn{
    if (_arrayccn == nil) {
        self.arrayccn = [NSMutableArray new];
    }
    return _arrayccn;
}

- (IBAction)setingViewAction:(id)sender {

    
        UIStoryboard *setStoryboard = [UIStoryboard storyboardWithName:@"SetStoryboard" bundle:nil];
        SetViewController *setVC = [setStoryboard instantiateViewControllerWithIdentifier:@"setView"];
    [self.navigationController pushViewController:setVC animated:YES];

}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:YES];
    
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
