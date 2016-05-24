//
//  UIBarButtonItem+CQExtension.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by 廖启旋 on 16/4/30.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "UIBarButtonItem+CQExtension.h"

@implementation UIBarButtonItem (CQExtension)
+(instancetype)itemWithTarget:(id)target sel:(SEL)sel imageName:(NSString *)imageName highImageName:(NSString *)highImageName{
    UIButton *btn = [[UIButton alloc]init];
    [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    btn.size = btn.currentBackgroundImage.size;
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];

}

@end
