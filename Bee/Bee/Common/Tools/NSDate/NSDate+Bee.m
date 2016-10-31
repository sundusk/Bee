//
//  NSDate+YS.m
//  工具包-OC
//
//  Created by yaoshuai on 16/8/15.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "NSDate+Bee.h"

@implementation NSDate (Bee)

- (NSDateComponents *)components
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *com = [calendar components:NSCalendarUnitYear | NSCalendarUnitQuarter | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitNanosecond | NSCalendarUnitWeekday fromDate:self];
    
    return com;
}

- (NSInteger)year
{
    return [self components].year;
}
- (NSInteger)month
{
    return [self components].month;
}
- (NSInteger)day
{
    return [self components].day;
}
- (NSInteger)hour
{
    return [self components].hour;
}
- (NSInteger)minute
{
    return [self components].minute;
}
- (NSInteger)second
{
    return [self components].second;
}
- (NSInteger)nanosecond
{
    return [self components].nanosecond;
}
- (NSInteger)weekday
{
    return [self components].weekday;
}

@end
