//
//  YS_MyShopVC.m
//  Bee
//
//  Created by yaoshuai on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "YS_MyShopVC.h"

@interface YS_MyShopVC ()


@end

@implementation YS_MyShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的店铺";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
}

#pragma mark - 布局界面
- (void)setupUI
{
    UIImageView *noShopImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"v2_store_empty"]];
    [self.view addSubview:noShopImgV];
    
    UILabel *noShopLbl = [UILabel bee_labelWithText:@"还没有收藏的店铺呦～" andColor:[UIColor blackColor] andFontSize:15.0f];
    noShopLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:noShopLbl];
    
    [noShopImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(90);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(150);
    }];
    [noShopLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(noShopImgV.mas_bottom).offset(10);
        make.left.right.offset(0);
    }];
}

@end
