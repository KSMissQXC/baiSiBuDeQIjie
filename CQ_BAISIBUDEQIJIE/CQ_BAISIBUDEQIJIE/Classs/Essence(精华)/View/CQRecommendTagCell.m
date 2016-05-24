//
//  CQRecommendTagCell.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/2.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQRecommendTagCell.h"
#import "CQRecommendTagItem.h"
#import <UIImageView+WebCache.h>

@interface CQRecommendTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detaLabel;

@end


@implementation CQRecommendTagCell

+(instancetype)recommendTagCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"tagCell";
    CQRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    }
    return cell;
}

-(void)setItem:(CQRecommendTagItem *)item{
    _item = item;
     [self.iconImage sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = item.theme_name;
    NSString *subNumber = nil;
    if (item.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅", item.sub_number];
    }else { // 大于等于10000
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅", item.sub_number / 10000.0];
    }
    self.detaLabel.text = subNumber;

}

-(void)setFrame:(CGRect)frame{
    frame.origin.x += 5;
    frame.size.height -= 1;
    frame.size.width -= 2 * frame.origin.x;
    [super setFrame:frame];
}








@end
