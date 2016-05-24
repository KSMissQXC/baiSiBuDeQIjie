//
//  CQMeCellTableViewCell.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/17.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQMeCell.h"

@implementation CQMeCell


+(instancetype)meCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"me";
    CQMeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CQMeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView{
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    self.textLabel.textColor = [UIColor darkGrayColor];
    self.textLabel.font = [UIFont systemFontOfSize:14];
    self.selectionStyle = UITableViewCellSeparatorStyleNone;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.imageView.image == nil) return;
    self.imageView.width = 30;
    self.imageView.height = self.imageView.width;
    self.imageView.x = CQTopicCellMargin;
    self.imageView.centerY = self.contentView.height * 0.5;
    
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + CQTopicCellMargin;
    self.textLabel.centerY = self.contentView.height * 0.5;

}


















@end
