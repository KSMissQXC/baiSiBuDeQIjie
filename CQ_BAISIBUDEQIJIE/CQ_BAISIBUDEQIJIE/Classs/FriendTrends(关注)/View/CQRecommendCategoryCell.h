//
//  CQRecommendCategoryCell.h
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/2.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CQRecommendCategoryItem;
@interface CQRecommendCategoryCell : UITableViewCell
@property (strong, nonatomic)CQRecommendCategoryItem *item;
+(instancetype)recommendCategoryCellWithTableView:(UITableView *)tableView;



@end
