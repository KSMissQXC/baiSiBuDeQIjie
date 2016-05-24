//
//  CQRecommendController.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/2.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQRecommendController.h"
#import "CQRecommendCategoryItem.h"
#import "CQRecommendCategoryCell.h"
#import "CQRecommendUserItem.h"
#import "CQRecommendUserCell.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>

#define CQSelectedCategory self.categoriesArray[self.leftTableView.indexPathForSelectedRow.row]

@interface CQRecommendController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *leftTableView;

@property (weak, nonatomic) IBOutlet UITableView *rightTableView;

@property (strong, nonatomic)NSArray *categoriesArray;

//@property (strong, nonatomic)NSArray *userArray;
@property (strong, nonatomic)AFHTTPSessionManager *magger;
@property (weak, nonatomic)NSDictionary *params;

@property (weak, nonatomic)CQRecommendCategoryItem *justItem;





@end

@implementation CQRecommendController


-(AFHTTPSessionManager *)magger{
    if (_magger == nil) {
        _magger = [AFHTTPSessionManager manager];
    }
    return _magger;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化控件
    [self setupTableView];
    
    //集成刷新
    [self setupRefresh];
    
    //获取左边数据
    [self loadCategories];
    
    
}

-(void)setupRefresh{
    self.rightTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    self.rightTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    

}

-(void)loadNewUsers{
    CQRecommendCategoryItem *categoryItem = CQSelectedCategory;
    categoryItem.currentPage = 1;

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = categoryItem.ID;
    params[@"page"] = @(categoryItem.currentPage);
    self.params = params;
    //发送请求加载右侧数据
    [self.magger GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (self.params != params) return ;
        NSArray *userA = [CQRecommendUserItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [categoryItem.usersArray removeAllObjects];
        [categoryItem.usersArray addObjectsFromArray:userA];
        categoryItem.total = [responseObject[@"total"] integerValue];
        //结束刷新
        [self.rightTableView.mj_header endRefreshing];
        [self chectFooter];
        [self.rightTableView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
//        [SVProgressHUD showErrorWithStatus:@"网络不给力"];

    }];
    

    
    
}

-(void)loadMoreUsers{
    CQRecommendCategoryItem *categoryItem = CQSelectedCategory;
    // 请求参数
//    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = categoryItem.ID;
    params[@"page"] = @(++categoryItem.currentPage);
    self.params = params;

    [self.magger GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) return ;

        NSArray *userA = [CQRecommendUserItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [categoryItem.usersArray addObjectsFromArray:userA];
        //结束刷新
        [self.rightTableView.mj_footer endRefreshing];
        [self.rightTableView reloadData];
        
        [self chectFooter];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
 
}


-(void)loadCategories{
    //显示器,发送网络请求
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [self.magger GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        self.categoriesArray = [CQRecommendCategoryItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.leftTableView reloadData];
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        self.justItem = self.categoriesArray[0];
        [self.rightTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"网络不给力"];
        
    }];

}

-(void)chectFooter{
    CQRecommendCategoryItem *item = CQSelectedCategory;
    self.rightTableView.mj_footer.hidden = (item.usersArray.count == 0);
    if (item.usersArray.count == item.total) {
        [self.rightTableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.rightTableView.mj_footer endRefreshing];
    }

}

-(void)setupTableView{
    self.view.backgroundColor = CQGlobalBg;
    self.title = @"推荐关注";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.leftTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.rightTableView.contentInset = self.leftTableView.contentInset;
    self.rightTableView.rowHeight = 70;

}




#pragma mark - tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.leftTableView) {
        return self.categoriesArray.count;
    }else{
        [self chectFooter];
        return [CQSelectedCategory usersArray].count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        CQRecommendCategoryItem *item = self.categoriesArray[indexPath.row];
        CQRecommendCategoryCell *cell = [CQRecommendCategoryCell recommendCategoryCellWithTableView:tableView];
        cell.item = item;
        return cell;
    }else{
        CQRecommendUserCell *cell = [CQRecommendUserCell recommendUserCellWithTableView:tableView];
        CQRecommendCategoryItem *item = CQSelectedCategory ;
        cell.userItem = item.usersArray[indexPath.row];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //结束刷新操作
    [self.rightTableView.mj_header endRefreshing];
    [self.rightTableView.mj_footer endRefreshing];
    
    
    
    //发送数据给服务器加载右边数据
    if (tableView == self.leftTableView) {
        self.justItem.offsetPoint = self.rightTableView.contentOffset;
        CQRecommendCategoryItem *item = self.categoriesArray[indexPath.row];
        self.justItem = item;
        if (item.usersArray.count) {
            [self.rightTableView reloadData];
            [self.rightTableView setContentOffset:item.offsetPoint animated:NO];
            return;
        }else{
            [self.rightTableView reloadData];
            [self.rightTableView.mj_header beginRefreshing];

        }
    }
}







-(void)dealloc{
    [self.magger.operationQueue cancelAllOperations];
}














@end
