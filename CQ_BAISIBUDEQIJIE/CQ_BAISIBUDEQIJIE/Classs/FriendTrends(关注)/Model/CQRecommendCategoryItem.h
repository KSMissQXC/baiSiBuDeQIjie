//
//  CQRecommendCategoryItem.h
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/2.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CQRecommendCategoryItem : NSObject

@property (copy, nonatomic)NSString *ID;
@property (copy, nonatomic)NSString *name;
@property (copy, nonatomic)NSString *count;
@property (strong, nonatomic)NSMutableArray *usersArray;

@property (assign, nonatomic)CGPoint offsetPoint;


/** 总数 */
@property (nonatomic, assign) NSInteger total;
/** 当前页码 */
@property (nonatomic, assign) NSInteger currentPage;



@end
