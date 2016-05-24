//
//  CQTabBar.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by 廖启旋 on 16/4/30.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQTabBar.h"
#import "CQPublishView.h"
#import "CQPostWordController.h"
#import "CQNavigationController.h"

@interface CQTabBar ()
@property(nonatomic,weak)UIButton *publishBtn;


@end

@implementation CQTabBar

#pragma mark - 初始化
-(instancetype)init{
    self = [super init];
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light" ]];
        UIButton *btn = [[UIButton alloc]init];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        btn.size = btn.currentBackgroundImage.size;
        self.publishBtn = btn;
        [btn addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
}



#pragma mark - 布局子控件
-(void)layoutSubviews{
    [super layoutSubviews];
    //计算发布按钮的Frame
    static BOOL flag = NO;
    self.publishBtn.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    CGFloat width = self.width / 5;
    CGFloat height = self.height;
    NSInteger index = 0;
    for (UIControl *v in self.subviews) {
        if (![v isKindOfClass:NSClassFromString(@"UITabBarButton")]){
                       continue;}
        CGFloat btnX = ((index > 1) ? (index + 1):index) * width;
        v.frame = CGRectMake(btnX, 0, width, height);
        index++;
        
        if (flag == NO) {
            [v addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    flag = YES;
    
}

#pragma mark - 事件监听
-(void)btnClick{
    [CQNotificationCenter postNotificationName:CQTabBarDidSelectNotification object:nil];
    
}

-(void)publishClick{
    CQPostWordController *vc = [[CQPostWordController alloc]init];
    CQNavigationController *nav = [[CQNavigationController alloc]initWithRootViewController:vc];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
    
}


















@end
