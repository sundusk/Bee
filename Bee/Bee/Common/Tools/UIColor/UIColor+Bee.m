//
//  UIColor+Extension.m
//  test
//
//  Created by yaoshuai on 16/7/12.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "UIColor+Bee.h"

@implementation UIColor (Bee)

+ (instancetype)bee_colorWithRed:(short)red andGreen:(short)green andBlue:(short)blue andAlpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:red / 255.0f green:green / 255.0f blue:blue / 255.0f alpha:alpha];
}

+ (instancetype)bee_colorWithHex:(int32_t)hex andAlpha:(CGFloat)alpha
{
    short red = (hex & 0xFF0000) >> 16;
    short green = (hex & 0x00FF00) >> 8;
    short blue = hex & 0x0000FF;
    return [self bee_colorWithRed:red andGreen:green andBlue:blue andAlpha:alpha];
}

+ (instancetype)bee_randomColor
{
    return [self bee_colorWithRed:arc4random_uniform(256) andGreen:arc4random_uniform(256) andBlue:arc4random_uniform(256) andAlpha:1];
}

@end
