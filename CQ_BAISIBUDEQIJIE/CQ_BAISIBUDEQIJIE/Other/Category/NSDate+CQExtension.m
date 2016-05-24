//
//  NSDate+CQExtension.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by 廖启旋 on 16/5/7.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "NSDate+CQExtension.h"

@implementation NSDate (CQExtension)

-(NSDateComponents *)cq_componentsToNowDate{
    //获取日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}



-(BOOL)cq_isThisYear{
    //获取日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    return nowYear == selfYear;
}

-(BOOL)cq_isToday{
    //判断是否为今天去掉,时分秒的影响,把时间先按照年月日来格式化在比较是否一样
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [formatter stringFromDate:self];
    NSString *nowStr = [formatter stringFromDate:[NSDate date]];
    return [selfStr isEqualToString:nowStr];
}

-(BOOL)cq_isYesterday{
    //判断是否为今天去掉,时分秒的影响
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *selfStr = [formatter stringFromDate:self];
    NSDate *selfDate = [formatter dateFromString:selfStr];
    
    NSString *nowStr = [formatter stringFromDate:[NSDate date]];
    NSDate *nowDate = [formatter dateFromString:nowStr];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return components.year == 0 && components.month == 0 && components.day == 1;
}







@end
