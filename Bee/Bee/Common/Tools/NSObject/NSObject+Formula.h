//
//  NSObject+Formula.h
//  工具包-OC
//
//  Created by yaoshuai on 16/8/13.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>

typedef struct{
    CGFloat startValue;
    CGFloat endValue;
}BeeValue;

/**
 *  用法示例：YSValue to = YSValueMake(1,100);
 *
 *  @param startValue 开始值
 *  @param endValue   结束值
 *
 *  @return 开始、结束值组成的结构体
 */
static inline BeeValue NBValueMake(CGFloat startValue, CGFloat endValue)
{
    BeeValue value;
    value.startValue = startValue;
    value.endValue = endValue;
    return value;
}

@interface NSObject (Formula)

/**
 *  根据参考获取结果(如:目标1-1000,参考100-10000,开始与结束值对应,那么参考值为555时，返回5.55)
 *
 *  @param consule      参考值
 *  @param resultValue  结果的start到end
 *  @param consultValue 参考的start到end
 *
 *  @return 结果指
 */
+ (CGFloat)bee_resultWithConsult:(CGFloat)consule andResultValue:(BeeValue)resultValue andConsultValue:(BeeValue)consultValue;

@end