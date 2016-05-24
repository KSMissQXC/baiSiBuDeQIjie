//
//  CQCommentController.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/15.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQCommentController.h"
#import "CQTopicCell.h"
#import "CQTopic.h"
#import "CQComment.h"
#import "CQCommentCell.h"
#import "CQCommentHeaderView.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import <AFNetworking.h>

@interface CQCommentController ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *bottomToolbarView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomDistance;

@property (strong, nonatomic)NSArray *hotsCommentArray;

@property (strong, nonatomic)NSMutableArray *latestCommentsArray;

@property (assign, nonatomic)NSInteger page;

@property (strong, nonatomic)AFHTTPSessionManager *manager;





@end

@implementation CQCommentController

#pragma mark - 懒加载
-(AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;

}

-(NSArray *)hotsCommentArray{
    if (_hotsCommentArray == nil) {
        _hotsCommentArray = [NSArray array];
    }
    return _hotsCommentArray;
}

-(NSMutableArray *)latestCommentsArray{
    if (_latestCommentsArray == nil) {
        _latestCommentsArray = [NSMutableArray array];
    }
    return _latestCommentsArray;
    
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    
    [self setupHeader];
    
    [self setupRefresh];

}

-(void)setupHeader{
    //外面包装一个view,tableViewHeader的高度会随时变化,一直会调用setFrame方法
    UIView *headView = [[UIView alloc]init];
    headView.height = self.topic.cellHeight;
    CQTopicCell *cell = [CQTopicCell viewFromXib];
    cell.topic = self.topic;
    cell.size = CGSizeMake(SCREEN_WIDTH, self.topic.cellHeight);
    [headView addSubview:cell];
    self.tableView.tableHeaderView = headView;
}

-(void)setupBasic{
    self.title = @"评论";
    [CQNotificationCenter addObserver:self selector:@selector(keyboardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.tableView.sectionHeaderHeight = 40;
    self.tableView.backgroundColor = CQGlobalBg;
    
}

-(void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

-(void)setTopic:(CQTopic *)topic{
    _topic = [topic copy];
    //需要重新计算cell的高度
    _topic.cellHeight = 0;
    _topic.top_cmt = nil;
    
}


#pragma mark 加载最新数据
-(void)loadNewData{
    // 参数
    //清除之前的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params        progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 字典 -> 模型
        self.hotsCommentArray = [CQComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        self.latestCommentsArray = [CQComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView reloadData];
        self.page = 0;
        [self.tableView.mj_header endRefreshing];
        //控制footer状态
        NSInteger totale = [responseObject[@"total"] integerValue];
        if (self.latestCommentsArray.count >= totale) {
            self.tableView.mj_footer.hidden = YES;
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];

}

#pragma mark 加载更多数据
-(void)loadMoreData{
    
    // 参数
    //清除之前的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSInteger page = self.page + 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    CQComment *cmt = self.latestCommentsArray.lastObject;
    params[@"lastcid"] = cmt.ID;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params        progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 字典 -> 模型
        //最新评论
        NSArray *newComments = [CQComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestCommentsArray addObjectsFromArray:newComments];
                                
        
        self.page = page;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        //控制footer状态
        NSInteger totale = [responseObject[@"total"] integerValue];
        if (self.latestCommentsArray.count >= totale) {
            self.tableView.mj_footer.hidden = YES;
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
    }];

}





#pragma mark - 事件处理
-(void)keyboardChangeFrame:(NSNotification *)noti{
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect endFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottomDistance.constant = SCREEN_HEIGHT - endFrame.origin.y;
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(void)ding:(UIMenuController *)menu{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%@",[self commentIndexPath:indexPath].content);
    
}

-(void)replay:(UIMenuController *)menu{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%@",[self commentIndexPath:indexPath].content);
    
}

-(void)report:(UIMenuController *)menu{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%@",[self commentIndexPath:indexPath].content);
}



#pragma mark - 代理方法
#pragma mark  tableView代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSInteger hotCount = self.hotsCommentArray.count;
    NSInteger commentCount = self.latestCommentsArray.count;
    if (hotCount) return 2;
    if (commentCount) return 1;
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger hotCount = self.hotsCommentArray.count;
    NSInteger commentCount = self.latestCommentsArray.count;
    tableView.mj_footer.hidden = (commentCount == 0);
    if (section == 0) return hotCount ? hotCount : commentCount;
    return commentCount;
}


//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    NSInteger hotCount = self.hotsCommentArray.count;
//    if (section == 0) return hotCount ? @"最热评论" : @"最新评论";
//    return @"最新评论";
//}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    CQCommentHeaderView *headView = [CQCommentHeaderView commentHeaderViewWithTableView:tableView];
    NSInteger hotCount = self.hotsCommentArray.count;
    if (section == 0) {
        headView.title = hotCount ? @"最热评论" : @"最新评论";
    }else{
        headView.title = @"最新评论";
    }
    return headView;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CQCommentCell *cell = [CQCommentCell commentCellWithTabelView:tableView];
    cell.comment = [self commentIndexPath:indexPath];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CQComment *comment = [self commentIndexPath:indexPath];
    return comment.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
    }else{
        CQCommentCell *cell = (CQCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
        [cell becomeFirstResponder];
        UIMenuItem *ding = [[UIMenuItem alloc]initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem *replay = [[UIMenuItem alloc]initWithTitle:@"回复" action:@selector(replay:)];
        UIMenuItem *report = [[UIMenuItem alloc]initWithTitle:@"局部" action:@selector(report:)];
        menu.menuItems = @[ding,replay,report];

        CGRect showRect = CGRectMake(0, cell.height * 0.5, cell.width, cell.height);
        [menu setTargetRect:showRect inView:cell];
        [menu setMenuVisible:YES animated:YES];
    }
}

#pragma mark scrollView代理
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
    [[UIMenuController sharedMenuController]setMenuVisible:NO animated:YES];
}

#pragma mark - 私有方法
-(CQComment *)commentIndexPath:(NSIndexPath *)indexPath{
   
    return [self commentsInSection:indexPath.section][indexPath.row];

}

-(NSArray *)commentsInSection:(NSInteger)section{
    if (section == 0) {
        return self.hotsCommentArray.count ? self.hotsCommentArray : self.latestCommentsArray;
    }
    return self.latestCommentsArray;
}

#pragma mark - 其它
-(void)dealloc{
    [CQNotificationCenter removeObserver:self];
    [self.manager invalidateSessionCancelingTasks:YES];
}











@end
