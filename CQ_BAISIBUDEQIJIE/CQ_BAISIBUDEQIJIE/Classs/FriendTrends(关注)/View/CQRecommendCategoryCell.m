//
//  CQRecommendCategoryCell.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/2.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQRecommendCategoryCell.h"
#import "CQRecommendCategoryItem.h"

@interface CQRecommendCategoryCell ()
@property (weak, nonatomic) IBOutlet UIView *selectedView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;



@end


@implementation CQRecommendCategoryCell


+(instancetype)recommendCategoryCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell";
    CQRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
        cell.backgroundColor = CQRGBColor(244, 244, 244);
    }
    return cell;
}


-(void)setItem:(CQRecommendCategoryItem *)item{
    _item = item;
    self.textLabel.text = item.name;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectedView.hidden = !selected;
    self.textLabel.textColor = selected ? CQRGBColor(219, 21, 26) :  CQRGBColor(78, 78, 78);

}

@end
