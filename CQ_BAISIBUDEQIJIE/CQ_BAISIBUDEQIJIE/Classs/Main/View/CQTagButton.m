//
//  CQTagButton.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQTagButton.h"

@implementation CQTagButton

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = CQTagBg;
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return self;
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    [self sizeToFit];
    self.width += 3 * CQTagMargin;
    self.height = CQTagHeight;

    
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.x = CQTagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + CQTagMargin;

}












@end
