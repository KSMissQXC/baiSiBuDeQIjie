//
//  CQMeController.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by 廖启旋 on 16/4/30.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQMeController.h"
#import "CQMeCell.h"
#import "CQFooterView.h"

@interface CQMeController ()
@property (strong, nonatomic)CQFooterView *footerView;


@end

@implementation CQMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTableView];
    
}

-(void)setupTableView{
    self.tableView.backgroundColor = CQGlobalBg;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.tableView.sectionFooterHeight = CQTopicCellMargin;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(CQTopicCellMargin - 35, 0, 0, 0);
    self.footerView = [[CQFooterView alloc]init];
    __weak typeof(self) weakSelf = self;
    self.footerView.block = ^(CGFloat height){
        
        
        weakSelf.footerView.height = height;
        weakSelf.tableView.tableFooterView = weakSelf.footerView;
    };

}

-(void)setupNav{
    // 设置导航栏标题
    self.navigationItem.title = @"我的";
    
    // 设置导航栏右边的按钮
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingButton setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
    [settingButton setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
    settingButton.size = settingButton.currentBackgroundImage.size;
    [settingButton addTarget:self action:@selector(settingClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *nightModeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nightModeButton setBackgroundImage:[UIImage imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
    [nightModeButton setBackgroundImage:[UIImage imageNamed:@"mine-moon-icon-click"] forState:UIControlStateHighlighted];
    nightModeButton.size = nightModeButton.currentBackgroundImage.size;
    [nightModeButton addTarget:self action:@selector(nightModeClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = @[
                                                [[UIBarButtonItem alloc] initWithCustomView:settingButton],
                                                [[UIBarButtonItem alloc] initWithCustomView:nightModeButton]
                                                ];
    

}


-(void)nightModeClick{
    CQLogFunc;
}

-(void)settingClick{
    CQLogFunc;
}

#pragma mark -tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CQMeCell *cell = [CQMeCell meCellWithTableView:tableView];
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"mine_icon_nearby"];
        cell.textLabel.text = @"登录/注册";
    }else if(indexPath.section == 1){
        cell.textLabel.text = @"离线下载";
        
    }
    return cell;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    NSLog(@"%@",NSStringFromUIEdgeInsets(scrollView.contentInset));
//    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    
}


























@end
