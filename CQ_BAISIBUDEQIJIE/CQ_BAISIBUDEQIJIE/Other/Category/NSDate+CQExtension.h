//
//  NSDate+CQExtension.h
//  CQ_BAISIBUDEQIJIE
//
//  Created by 廖启旋 on 16/5/7.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CQExtension)
-(BOOL)cq_isThisYear;
-(BOOL)cq_isToday;
-(BOOL)cq_isYesterday;

-(NSDateComponents *)cq_componentsToNowDate;




@end
