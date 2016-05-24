//
//  CQTopWindow.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQTopWindow.h"

@implementation CQTopWindow

static UIWindow *window_;

+(void)initialize{
    window_ = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    window_.windowLevel = UIWindowLevelStatusBar;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapWindowClick)];
    [window_ addGestureRecognizer:tap];
}

+(void)show{
    window_.hidden = NO;
}

+(void)tapWindowClick{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [self searchCurrentShowScrollViewFromSuperView:keyWindow];

}

+(void)searchCurrentShowScrollViewFromSuperView:(UIView *)superview{
    
    for (UIScrollView *scroView in superview.subviews) {
        if ([scroView isKindOfClass:[UIScrollView class]] && scroView.isJustShowView) {
            CGPoint offset = scroView.contentOffset;
            offset.y = - scroView.contentInset.top;
            [scroView setContentOffset:offset animated:YES];
        }
        [self searchCurrentShowScrollViewFromSuperView:scroView];
    }
    

}

















@end
