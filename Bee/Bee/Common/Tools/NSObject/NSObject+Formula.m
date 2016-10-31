//
//  NSObject+Formula.m
//  工具包-OC
//
//  Created by yaoshuai on 16/8/13.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "NSObject+Formula.h"

@implementation NSObject (Formula)

/**
 *  根据参考获取结果
 *
 *  @param consule      参考值
 *  @param resultValue  结果的start到end
 *  @param consultValue 参考的start到end
 *
 *  @return 结果指
 */
+ (CGFloat)bee_resultWithConsult:(CGFloat)consule andResultValue:(BeeValue)resultValue andConsultValue:(BeeValue)consultValue
{
    // a * r.start + b = c.start
    // a * r.end + b = c.end
    
    // a * (r.start - r.end) + b = c.start - c.ent;
    
    CGFloat a = (resultValue.startValue - resultValue.endValue) / (consultValue.startValue - consultValue.endValue);
    CGFloat b = resultValue.startValue - (a * consultValue.startValue);
    
    return a * consule + b;
}

@end
