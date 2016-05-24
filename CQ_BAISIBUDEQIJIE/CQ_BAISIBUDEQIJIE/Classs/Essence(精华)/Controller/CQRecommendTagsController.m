//
//  CQRecommendTagsController.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/2.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQRecommendTagsController.h"
#import "CQRecommendTagItem.h"
#import "CQRecommendTagCell.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>

@interface CQRecommendTagsController ()
@property (strong, nonatomic)NSArray *tagArray;


@end

@implementation CQRecommendTagsController

#pragma mark - 懒加载
-(NSArray *)tagArray{
    if (_tagArray == nil) {
        _tagArray = [NSArray array];
    }
    return _tagArray;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self loadTags];

}

-(void)setupTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = CQGlobalBg;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.rowHeight = 70;
    
}


#pragma mark 加载数据
-(void)loadTags{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        self.tagArray = [CQRecommendTagItem mj_objectArrayWithKeyValuesArray:responseObject];
    
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
        
    }];
    
}

#pragma mark - 代理方法
#pragma mark  Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tagArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CQRecommendTagItem *item = self.tagArray[indexPath.row];
    CQRecommendTagCell *cell = [CQRecommendTagCell recommendTagCellWithTableView:tableView];
    cell.item = item;
    return cell;
}


@end
