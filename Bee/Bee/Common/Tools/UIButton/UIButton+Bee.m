//
//  UIButton+YS.m
//  tst
//
//  Created by yaoshuai on 16/8/4.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "UIButton+Bee.h"

@implementation UIButton (Bee)

+ (instancetype)bee_buttonWithTitle:(NSString *)title andFontSize:(CGFloat)fontSize andNormalColor:(UIColor *)normalColor andSelectedColor:(UIColor *)selectedColor {
    
    UIButton *button = [[self alloc] init];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:selectedColor forState:UIControlStateSelected];
    
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    [button sizeToFit];
    
    return button;
}

@end