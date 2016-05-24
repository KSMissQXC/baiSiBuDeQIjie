//
//  UIBarButtonItem+CQExtension.h
//  CQ_BAISIBUDEQIJIE
//
//  Created by 廖启旋 on 16/4/30.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CQExtension)
+(instancetype)itemWithTarget:(id)target sel:(SEL)sel imageName:(NSString *)imageName highImageName:(NSString *)highImageName;

@end
