//
//  UIColor+Extension.h
//  test
//
//  Created by yaoshuai on 16/7/12.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Bee)

/**
 *  根据RGB的10进制值获取颜色
 *
 *  @param red   Red的10进制
 *  @param green Greed的10进制
 *  @param blue  Blue的10进制
 *  @param alpha 不透明度
 *
 *  @return 返回UIColor
 */
+ (instancetype)bee_colorWithRed:(short)red andGreen:(short)green andBlue:(short)blue andAlpha:(CGFloat)alpha;

/**
 *  根据RGB的16进制值获取颜色
 *
 *  @param hex   16进制数，如：0xA4B3C2
 *  @param alpha 不透明度
 *
 *  @return 返回UIColor
 */
+ (instancetype)bee_colorWithHex:(int32_t)hex andAlpha:(CGFloat)alpha;

/**
 *  得到一个随机色
 *
 *  @return 获取到的随机色
 */
+ (instancetype)bee_randomColor;

@end
