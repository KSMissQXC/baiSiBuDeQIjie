//
//  CQPushGuideView.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/4.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQPushGuideView.h"

@implementation CQPushGuideView

+(void)show{
    //拿到版本号
    NSLog(@"%@",[NSBundle mainBundle].infoDictionary);
    NSString *key = @"CFBundleShortVersionString";
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSLog(@"%@",currentVersion);
    
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (![currentVersion isEqualToString:sanboxVersion]) {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        CQPushGuideView *guideV = [self pushGuideView];
        guideV.frame = keyWindow.bounds;
        [keyWindow addSubview:guideV];
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}

+(instancetype)pushGuideView{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}


- (IBAction)btnClick:(UIButton *)sender {
    
    [self removeFromSuperview];
    
    
}




@end
