//
//  CQCommentHeaderView.h
//  CQ_BAISIBUDEQIJIE
//
//  Created by 廖启旋 on 16/5/15.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CQCommentHeaderView : UITableViewHeaderFooterView

+(instancetype)commentHeaderViewWithTableView:(UITableView *)tableView;

@property(nonatomic,copy)NSString * title;

@end
