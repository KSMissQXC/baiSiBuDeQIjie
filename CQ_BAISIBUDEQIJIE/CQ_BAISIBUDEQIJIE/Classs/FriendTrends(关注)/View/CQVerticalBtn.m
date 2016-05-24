//
//  CQVerticalBtn.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/3.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQVerticalBtn.h"

@implementation CQVerticalBtn

-(void)awakeFromNib{
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}


-(instancetype)init{
    self = [super init];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;

    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    // 调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height + 5;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

@end
