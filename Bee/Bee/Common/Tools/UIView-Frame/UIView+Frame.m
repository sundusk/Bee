//
//  UIView+HMFrame.m
//  HMDeliver
//
//  Created by JackMeng on 16/3/14.
//  Copyright © 2016年 YosonHao. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
- (void)setX:(CGFloat)x
{
    CGRect rect = self.frame;

    rect.origin.x = x;

    self.frame = rect;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect rect = self.frame;

    rect.origin.y = y;

    self.frame = rect;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setW:(CGFloat)w
{
    CGRect rect = self.frame;

    rect.size.width = w;

    self.frame = rect;
}

- (CGFloat)w
{
    return self.frame.size.width;
}

- (void)setH:(CGFloat)h
{
    CGRect rect = self.frame;

    rect.size.height = h;

    self.frame = rect;
}

- (CGFloat)h
{
    return self.frame.size.height;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)newCenterX
{
    self.center = CGPointMake(newCenterX, self.center.y);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)newCenterY
{
    self.center = CGPointMake(self.center.x, newCenterY);
}
@end
