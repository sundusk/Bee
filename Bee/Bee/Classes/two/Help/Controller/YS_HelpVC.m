//
//  YS_HelpVC.m
//  Bee
//
//  Created by yaoshuai on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "YS_HelpVC.h"

@interface YS_HelpVC ()

@end

@implementation YS_HelpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"客服帮助";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
}

#pragma mark - 布局界面
- (void)setupUI
{
    UILabel *mobileLbl = [UILabel bee_labelWithText:@"客服电话：400-8484-842" andColor:[UIColor blackColor] andFontSize:15.0f];
    mobileLbl.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mobileLbl];
    
    UILabel *problemLbl = [UILabel bee_labelWithText:@"常见问题" andColor:[UIColor blackColor] andFontSize:15.0f];
    problemLbl.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:problemLbl];
    
    [mobileLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(10);
        make.right.offset(-10);
        make.height.mas_equalTo(40);
    }];
    
    [problemLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mobileLbl.mas_bottom).offset(10);
        make.left.offset(10);
        make.right.offset(-10);
        make.height.mas_equalTo(40);
    }];
}

@end
