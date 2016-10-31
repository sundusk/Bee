//
//  UIViewController+YS.m
//  tst
//
//  Created by yaoshuai on 16/8/4.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "UIViewController+Bee.h"

@implementation UIViewController (Bee)

- (void)bee_addChildController:(UIViewController *)childController intoView:(UIView *)view{
    
    // 1> 添加子控制器 － 否则响应者链条会被打断，导致事件无法正常传递，而且错误非常难改！
    [self addChildViewController:childController];
    
    childController.view.frame = view.bounds;
    
    // 2> 添加子控制器的视图
    [view addSubview:childController.view];
    
    // 3> 完成子控制器的添加
    [childController didMoveToParentViewController:self];
}

@end
