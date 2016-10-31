//
//  UIView+Frame.h
//  test
//
//  Created by yaoshuai on 16/7/12.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Layout)

@property (assign, nonatomic) CGFloat x, y, centerX, centerY, width, height, top, bottom, left, right;

@property (assign, nonatomic) CGSize size;

@property (assign, nonatomic) CGPoint origin;

@end
