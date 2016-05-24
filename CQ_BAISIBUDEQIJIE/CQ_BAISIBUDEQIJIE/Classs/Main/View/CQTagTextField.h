//
//  CQTagTextField.h
//  CQ_BAISIBUDEQIJIE
//
//  Created by 廖启旋 on 16/5/18.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CQTagTextField : UITextField

@property(nonatomic,copy) void(^deleteTagBlock)();

@end
