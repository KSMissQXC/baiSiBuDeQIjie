//
//  CQSquareBtn.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/17.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQSquareBtn.h"
#import "CQSquare.h"
#import <UIButton+WebCache.h>

@implementation CQSquareBtn


-(instancetype)init{
    self = [super init];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    self.imageView.y = self.height * 0.15;
    
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.x = 0;
    self.titleLabel.y = self.height - self.titleLabel.height;

}

-(void)setSquare:(CQSquare *)square{
    _square = square;
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
    [self setTitle:square.name forState:UIControlStateNormal];
}




@end
