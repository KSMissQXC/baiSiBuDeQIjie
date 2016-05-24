//
//  CQTopicController.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/6.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQTopicController.h"
#import "CQTopic.h"
#import "CQTopicCell.h"
#import "CQCommentController.h"
#import "CQNewTopicController.h"
#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>

@interface CQTopicController ()

@property (assign, nonatomic)NSInteger page;
@property (weak, nonatomic)NSDictionary *params;
/** 当加载下一页数据时需要这个参数 */
@property (nonatomic, copy) NSString *maxtime;

@property (strong, nonatomic)NSMutableArray *dataArray;

@property (assign, nonatomic)NSInteger lastClickIndex;

@end

static NSString *const CQTopicCellID = @"topic";

@implementation CQTopicController

#pragma mark - 懒加载
-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self setupRefresh];
}


-(void)setupTableView{
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CQTopicCell class]) bundle:nil] forCellReuseIdentifier:CQTopicCellID];
    self.tableView.contentInset = UIEdgeInsetsMake(CQTitleViewsHeight + CQTitleViewsY, 0, CQTabBarHeight, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [CQNotificationCenter addObserver:self selector:@selector(tabBarSelect) name:CQTabBarDidSelectNotification object:nil];
}


-(void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.tableView.mj_header beginRefreshing];
    
}

#pragma mark 加载最新数据
-(void)loadNewData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.topicType);
    self.params = params;
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params        progress:^(NSProgress * _Nonnull downloadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) return ;
        self.maxtime =  responseObject[@"info"][@"maxtime"];
        self.dataArray = [CQTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        self.page = 0;

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];

    }];
    
}

#pragma mark 加载更多数据
-(void)loadMoreData{
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.topicType);
    NSInteger page = self.page + 1;
    params[@"page"] = @(page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params        progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) return ;
        self.maxtime =  responseObject[@"info"][@"maxtime"];
        // 字典 -> 模型
        NSArray *newTopics = [CQTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.dataArray addObjectsFromArray:newTopics];

        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        self.page = page;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}



#pragma mark - 事件处理
#pragma mark  监听到tabbar连续点击2次通知
-(void)tabBarSelect{
    if (self.lastClickIndex == self.tabBarController.selectedIndex && self.view.isJustShowView) {
        [self.tableView.mj_header beginRefreshing];
    }
    
    self.lastClickIndex = self.tabBarController.selectedIndex;
    
    
}


#pragma mark - 代理方法
#pragma mark  Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CQTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:CQTopicCellID];
    CQTopic *topic = self.dataArray[indexPath.row];
    cell.topic = topic;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CQTopic *topic = self.dataArray[indexPath.row];
    return topic.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CQCommentController *vc = [[CQCommentController alloc]init];
    vc.topic = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 私有方法
#pragma mark 获取加载参数
-(NSString *)a{
    return [self.parentViewController isKindOfClass:[CQNewTopicController class]] ? @"newlist" :@"list";
    
}

#pragma mark - 测试方法
-(void)dealloc{
    [CQNotificationCenter removeObserver:self];
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
