//
//  UIButton+YS.h
//  tst
//
//  Created by yaoshuai on 16/8/4.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Bee)

/**
 *  根据文字、字号、正常状态及高亮状态的颜色创建按钮
 *
 *  @param title         文字
 *  @param fontSize      字号
 *  @param normalColor   正常状态颜色
 *  @param selectedColor 高亮状态颜色
 *
 *  @return 返回创建的按钮
 */
+ (instancetype)bee_buttonWithTitle:(NSString *)title andFontSize:(CGFloat)fontSize andNormalColor:(UIColor *)normalColor andSelectedColor:(UIColor *)selectedColor;

@end