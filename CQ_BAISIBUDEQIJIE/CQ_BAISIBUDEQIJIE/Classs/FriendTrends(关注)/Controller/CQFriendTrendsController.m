//
//  CQFriendTrendsController.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by 廖启旋 on 16/4/30.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQFriendTrendsController.h"
#import "CQRecommendController.h"
#import "CQLoginRegisterController.h"
#import "CQPushGuideView.h"

@interface CQFriendTrendsController ()

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@end

@implementation CQFriendTrendsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CQGlobalBg;
    self.navigationItem.title = @"我的关注";
      self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self sel:@selector(leftClick) imageName:@"friendsRecommentIcon" highImageName:@"friendsRecommentIcon-click"];
    [CQPushGuideView show];
}

-(void)leftClick{
    CQRecommendController *vc = [[CQRecommendController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    

}



- (IBAction)loginBtnClick:(UIButton *)sender {
    CQLoginRegisterController *vc = [[CQLoginRegisterController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
    
    
    
}



@end
