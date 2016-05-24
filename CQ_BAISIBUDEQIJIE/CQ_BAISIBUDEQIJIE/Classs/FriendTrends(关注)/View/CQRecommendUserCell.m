//
//  CQRecommendUserCell.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/2.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQRecommendUserCell.h"
#import <UIImageView+WebCache.h>
#import "CQRecommendUserItem.h"

@interface CQRecommendUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detaLabel;



@end


@implementation CQRecommendUserCell



+(instancetype)recommendUserCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"userCell";
    CQRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
        
    }
    return cell;
}

-(void)setUserItem:(CQRecommendUserItem *)userItem{
    _userItem = userItem;
    self.nameLabel.text = userItem.screen_name;
    self.detaLabel.text = [NSString stringWithFormat:@"%zd人关注",userItem.fans_count];
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:userItem.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];

}
@end
