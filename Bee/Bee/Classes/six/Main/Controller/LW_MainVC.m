//
//  HLWMainVC.m
//  NBApp
//
//  Created by yaoshuai on 16/9/6.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "LW_MainVC.h"
#import "LW_LoginVC.h"
#import "LW_OrderTableVC.h"

@interface LW_MainVC ()

@end

@implementation LW_MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - 布局界面

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton bee_buttonWithTitle:@"测试" andFontSize:14 andNormalColor:[UIColor orangeColor] andSelectedColor:[UIColor redColor]];
    // MARK: - 按钮点击事件
    [btn addTarget:self action:@selector(loginVC) forControlEvents:UIControlEventTouchUpInside];
    
    [btn sizeToFit];
    btn.center = self.view.center;
    [self.view addSubview:btn];
    
    
    
    UIButton *btn1 = [UIButton bee_buttonWithTitle:@"我的订单" andFontSize:14 andNormalColor:[UIColor orangeColor] andSelectedColor:[UIColor redColor]];
    [self.view addSubview:btn1];
    // MARK: - 按钮点击事件
    [btn1 addTarget:self action:@selector(orderVC) forControlEvents:UIControlEventTouchUpInside];
    
    [btn1 sizeToFit];
//    btn1.center = self.view.center;
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn.mas_bottom).offset(10);
        make.centerX.equalTo(btn);
    }];
    

}

#pragma mark - 登陆界面
-(void)loginVC{
    
    LW_LoginVC *loginVC = [[LW_LoginVC alloc]initWithNibName:@"LW_LoginVC" bundle:nil];
    [[UIApplication sharedApplication].keyWindow setRootViewController:loginVC];
    
}
#pragma mark - 我的订单界面
-(void)orderVC{
    LW_OrderTableVC *orderVC = [[LW_OrderTableVC alloc] init];
    
    [[UIApplication sharedApplication].keyWindow setRootViewController:orderVC];
    
}
@end