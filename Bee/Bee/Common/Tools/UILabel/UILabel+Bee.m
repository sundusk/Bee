//
//  UILabel+YS.m
//  ZFBCollectionView
//
//  Created by yaoshuai on 16/7/13.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "UILabel+Bee.h"

@implementation UILabel (Bee)

+ (instancetype)bee_labelWithText:(NSString *)text andColor:(UIColor *)color andFontSize:(CGFloat)fontSize
{
    UILabel *label = [[self alloc] init];
    label.text = text;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.numberOfLines = 0;
    return label;
}

@end
