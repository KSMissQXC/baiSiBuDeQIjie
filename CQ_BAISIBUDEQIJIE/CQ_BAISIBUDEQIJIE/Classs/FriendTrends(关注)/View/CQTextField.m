//
//  CQTextField.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/4.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQTextField.h"
#import <objc/runtime.h>

@implementation CQTextField

-(void)awakeFromNib{
    self.tintColor = [UIColor whiteColor];
}

//+(void)load{
//    
//    unsigned int count = 0;
//    Ivar *ivars = class_copyIvarList([UITextField class], &count);
//    for (int i = 0; i < count; i++) {
//        NSLog(@"%s",ivar_getName(ivars[i]));
//    }
//    //_placeholderLabel
//}

-(BOOL)becomeFirstResponder{
    [self setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];
}

-(BOOL)resignFirstResponder{
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}





@end
