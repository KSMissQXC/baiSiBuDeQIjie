//
//  CQTagTextField.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by 廖启旋 on 16/5/18.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQTagTextField.h"

@implementation CQTagTextField


-(void)deleteBackward{
    if (self.text.length == 0) {
        self.deleteTagBlock ? self.deleteTagBlock() : nil;

    }
    
    [super deleteBackward];
}

@end
