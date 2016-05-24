//
//  CQRecommendCategoryItem.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/2.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQRecommendCategoryItem.h"
#import <MJExtension.h>

@implementation CQRecommendCategoryItem

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"ID" : @"id"};
}

-(NSMutableArray *)usersArray{
    if (_usersArray == nil) {
        _usersArray = [NSMutableArray array];
    }
    return _usersArray;
}


@end
