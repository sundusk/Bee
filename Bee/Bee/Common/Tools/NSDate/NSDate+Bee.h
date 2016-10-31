//
//  NSDate+YS.h
//  工具包-OC
//
//  Created by yaoshuai on 16/8/15.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Bee)

/**
 *  转换为当前时区的年、月、日、时、分、秒、微秒、星期(周日为1、周一为2...)
 */
@property (assign, nonatomic, readonly) NSInteger year, month, day, hour, minute, second, nanosecond, weekday;

@end
