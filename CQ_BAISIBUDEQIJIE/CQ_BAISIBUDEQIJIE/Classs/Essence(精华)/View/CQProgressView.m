//
//  CQProgressView.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/9.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQProgressView.h"

@implementation CQProgressView

-(void)awakeFromNib{
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

-(void)setProgress:(CGFloat)progress animated:(BOOL)animated{
    
    [super setProgress:progress animated:animated];
    NSString *text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    
}





@end
