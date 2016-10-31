//
//  UIViewController+YS.h
//  tst
//
//  Created by yaoshuai on 16/8/4.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Bee)

/**
 *  在当前视图控制器中添加子控制器，并将子控制器的视图添加到当前控制器的指定视图中
 *
 *  @param childController 子控制器
 *  @param view            当前控制器的指定视图
 */
- (void)bee_addChildController:(UIViewController *)childController intoView:(UIView *)view;

@end
