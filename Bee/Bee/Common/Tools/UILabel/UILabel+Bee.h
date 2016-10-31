//
//  UILabel+YS.h
//  ZFBCollectionView
//
//  Created by yaoshuai on 16/7/13.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Bee)

/**
 *  根据文本内容、颜色、字号创建UILabel对象
 *
 *  @param text     文本内容
 *  @param color    颜色
 *  @param fontSize 字号
 *
 *  @return 创建的UILabel对象
 */
+ (instancetype)bee_labelWithText:(NSString *)text andColor:(UIColor *)color andFontSize:(CGFloat)fontSize;

@end
