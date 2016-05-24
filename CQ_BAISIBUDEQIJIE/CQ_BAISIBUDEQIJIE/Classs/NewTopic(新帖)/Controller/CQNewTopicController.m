//
//  CQNewTopicController.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by 廖启旋 on 16/4/30.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQNewTopicController.h"

@interface CQNewTopicController ()

@end

@implementation CQNewTopicController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self sel:@selector(leftClick) imageName:@"MainTagSubIcon" highImageName:@"MainTagSubIconClick"];
}

-(void)leftClick{
    CQLogFunc;
}

@end
