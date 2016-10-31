//
//  YS_TabbarVC.m
//  Bee
//
//  Created by yaoshuai on 16/9/7.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "YS_TabbarVC.h"
#import "YS_NaviVC.h"
#import "YQ_ChaoShiVC.h"
#import "XW_HomeVC.h"
#import "DQ_MainVC.h"
#import "MG_MainVC.h"

@interface YS_TabbarVC ()

@end

@implementation YS_TabbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupControllers];
}

- (void)setupControllers
{
    self.tabBar.translucent = YES;
        self.tabBar.barTintColor = [UIColor bee_colorWithHex:0xe7e6ea andAlpha:1];
    YS_NaviVC *shouyeController = [self setTabBarItemWithController:[[XW_HomeVC alloc] init] andTitle:@"首页" andImageName:@"首页" andBadge:nil];
    YS_NaviVC *chaoshiController = [self setTabBarItemWithController:[[YQ_ChaoShiVC alloc] init] andTitle:@"闪电超市" andImageName:@"闪送" andBadge:nil];
    YS_NaviVC *carController = [self setTabBarItemWithController:[[DQ_MainVC alloc] init] andTitle:@"购物车" andImageName:@"购物车" andBadge:nil];
    
    YS_NaviVC *myController = [self setTabBarItemWithController:[[MG_MainVC alloc] init] andTitle:@"我的" andImageName:@"我的" andBadge:nil];
    
    self.viewControllers = @[shouyeController, chaoshiController, carController, myController];
    
}

- (YS_NaviVC *)setTabBarItemWithController:(UIViewController *)controller andTitle:(NSString *)title andImageName:(NSString *)imageName andBadge:(NSString *)badge
{
    controller.title = title;
    controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.badgeValue = badge;
    YS_NaviVC *nav = [[YS_NaviVC alloc] initWithRootViewController:controller];
    return nav;
}

+ (instancetype)sharedTBVC
{
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

@end
