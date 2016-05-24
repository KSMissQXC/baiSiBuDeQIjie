//
//  CQRecommendUserCell.h
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/2.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CQRecommendUserItem;
@interface CQRecommendUserCell : UITableViewCell

@property (strong, nonatomic)CQRecommendUserItem *userItem;
+(instancetype)recommendUserCellWithTableView:(UITableView *)tableView;




@end
