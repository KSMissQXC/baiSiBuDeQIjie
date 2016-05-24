//
//  CQFooterView.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/17.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQFooterView.h"
#import "CQSquare.h"
#import "CQSquareBtn.h"
#import "CQWebController.h"
#import <MJExtension.h>
#import <AFNetworking.h>



@implementation CQFooterView


-(instancetype)init{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        // 参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params        progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSArray *squres = [CQSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            [self createSqures:squres];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];

    }
    return self;
}

-(void)createSqures:(NSArray *)squres{
    
    int maxCols = 4;
    NSInteger count = squres.count;
    CGFloat btnW = SCREEN_WIDTH / maxCols;
    CGFloat btnH = btnW;
    
    for (NSInteger i = 0; i < count; i++) {
        CQSquareBtn *btn = [[CQSquareBtn alloc]init];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.square = squres[i];
        NSInteger xIndex = i % maxCols;
        NSInteger yIndex = i / maxCols;
        btn.frame = CGRectMake(xIndex * btnW, yIndex * btnH, btnW, btnH);
        [self addSubview:btn];
    }
    
    CGFloat height = ((count + maxCols - 1) / maxCols) * btnH;
    if (self.block) {
        self.block(height);
    }
 
}

-(void)btnClick:(CQSquareBtn *)btn{
    if (![btn.square.url hasPrefix:@"http"]) return;
    
    UITabBarController *tabBar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabBar.selectedViewController;
    
    CQWebController *webVc = [[CQWebController alloc]init];
    webVc.url = btn.square.url;
    webVc.title = btn.square.name;
    [nav pushViewController:webVc animated:YES];

}
















@end
