//
//  YS_NaviVC.m
//  Bee
//
//  Created by yaoshuai on 16/9/7.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "YS_NaviVC.h"

@interface YS_NaviVC ()

@end

@implementation YS_NaviVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationStyle];
}

#pragma mark - 设置导航栏样式
- (void)setupNavigationStyle
{
    //取消导航栏下面的分隔线
    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    //取消导航栏的半透明效果
    self.navigationBar.translucent = NO;
    
    //设置导航栏及UIBarButtonItem的颜色
    self.navigationBar.barTintColor = [UIColor orangeColor];
    self.navigationBar.tintColor = [UIColor whiteColor];
    
    //设置title颜色
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
}

#pragma mark - 统一设置状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

//将设置状态栏的操作交给具体的控制器
//- (UIViewController *)childViewControllerForStatusBarStyle
//{
//    return self.topViewController;
//}

#pragma mark - 重写pushViewController方法，隐藏标签栏
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self.viewControllers.count > 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
