//
//  CQRecommendTagCell.h
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/2.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CQRecommendTagItem;
@interface CQRecommendTagCell : UITableViewCell
@property (strong, nonatomic)CQRecommendTagItem *item;
+(instancetype)recommendTagCellWithTableView:(UITableView *)tableView;



@end
