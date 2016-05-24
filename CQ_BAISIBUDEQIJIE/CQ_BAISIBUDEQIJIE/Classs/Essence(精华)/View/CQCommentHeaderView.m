//
//  CQCommentHeaderView.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by 廖启旋 on 16/5/15.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQCommentHeaderView.h"

@interface CQCommentHeaderView ()


@property(nonatomic,weak)UILabel *label;


@end

@implementation CQCommentHeaderView
static NSString *ID = @"header";

#pragma mark - 初始化
+(instancetype)commentHeaderViewWithTableView:(UITableView *)tableView{
    CQCommentHeaderView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (headView == nil) {
        headView = [[CQCommentHeaderView alloc]initWithReuseIdentifier:ID];
    }
    return headView;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = CQGlobalBg;
        UILabel *label = [[UILabel alloc]init];
        label.textColor = CQRGBColor(67, 67, 67);
        label.textAlignment = NSTextAlignmentLeft;
        label.x = CQTopicCellMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.label.text = title;
    
}




@end
