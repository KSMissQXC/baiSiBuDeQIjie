//
//  CQPlaceholderTextView.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/17.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQPlaceholderTextView.h"

@interface CQPlaceholderTextView ()
@property (weak, nonatomic)UILabel *placeholderLabel;


@end

@implementation CQPlaceholderTextView


#pragma mark - 懒加载
-(UILabel *)placeholderLabel{
    if (_placeholderLabel == nil) {
        UILabel *label = [[UILabel alloc]init];
        label.font = self.font;
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor grayColor];
        label.numberOfLines = 0;
        label.x = 4;
        label.y = 7;
        [self addSubview:label];
        _placeholderLabel = label;
    }
    return _placeholderLabel;
}

#pragma mark - 初始化
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:15];
        self.tintColor = [UIColor grayColor];
        [CQNotificationCenter addObserver:self selector:@selector(textFinishDidChange:) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
    
}

-(void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeholderLabel.font = font;
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
    
}

#pragma mark - 事件方法
#pragma mark 接收到文字改变通知
-(void)textFinishDidChange:(NSNotification *)noti{
    
    self.placeholderLabel.hidden = self.hasText;
    
    
}




#pragma mark - 设置子控件Frame
-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.placeholder) {
        CGSize maxSize = CGSizeMake(self.width - 2 * self.placeholderLabel.x, MAXFLOAT);
        self.placeholderLabel.size = [self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:nil].size;

    }

}

















@end
