//
//  CQTabBarController.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by 廖启旋 on 16/4/30.
//  Copyright © 2016年 廖启旋. All rights reserved.
//

#import "CQTabBarController.h"
#import "CQEssenceController.h"
#import "CQNewTopicController.h"
#import "CQFriendTrendsController.h"
#import "CQMeController.h"
#import "CQTabBar.h"
#import "CQNavigationController.h"
#import "CQTopWindow.h"


@interface CQTabBarController ()

@end

@implementation CQTabBarController

#pragma mark - 初始化
+(void)initialize{
    //设置全局tabBar样式
    NSDictionary *dict = @{NSFontAttributeName :[UIFont systemFontOfSize:12],
                           NSForegroundColorAttributeName:[UIColor grayColor]};
    
    NSDictionary *selectedDict = @{NSFontAttributeName :[UIFont systemFontOfSize:12],
                                   NSForegroundColorAttributeName:[UIColor darkGrayColor]};
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedDict forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setValue:[[CQTabBar alloc]init] forKeyPath:@"tabBar"];
    [self setupAllChildController];
//    NSLog(@"%@",self.tabBar.subviews);
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [CQTopWindow show];

}

-(void)setupAllChildController{
    UIViewController *essenceVc = [[CQEssenceController alloc]init];
    [self addChildVc:essenceVc imageName:@"tabBar_essence_icon" selectedImageName:@"tabBar_essence_click_icon" title:@"精华"];
    
    UIViewController *newTopicVc= [[CQNewTopicController alloc]init];
    [self addChildVc:newTopicVc imageName:@"tabBar_new_icon" selectedImageName:@"tabBar_new_click_icon" title:@"新帖"];
   
    
    UIViewController *friendTrendVc = [[CQFriendTrendsController alloc]init];
    [self addChildVc:friendTrendVc imageName:@"tabBar_friendTrends_icon" selectedImageName:@"tabBar_friendTrends_click_icon" title:@"关注"];
    
    UIViewController *meVc = [[CQMeController alloc]initWithStyle:UITableViewStyleGrouped];
    [self addChildVc:meVc imageName:@"tabBar_me_icon" selectedImageName:@"tabBar_me_click_icon" title:@"我的"];
   
    
}


-(void)addChildVc:(UIViewController *)vc imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName title:(NSString *)title{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    CQNavigationController *nvc = [[CQNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:nvc];

}

@end
