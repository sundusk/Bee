//
//  DQ_BlankView.m
//  Bee
//
//  Created by Apple on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "DQ_BlankView.h"

@implementation DQ_BlankView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark -搭建界面
-(void)setupUI{
    //1.购物车图标
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"v2_shop_empty"]];
    [imageV sizeToFit];
    [self addSubview:imageV];
    
    //2.label字段
    UILabel *blankCautionLabel = [UILabel bee_labelWithText:@"亲,购物车空空的耶~赶紧的去挑好吃的吧" andColor:[UIColor grayColor] andFontSize:14];
    [self addSubview:blankCautionLabel];
    
    //3.跳转至超市按钮
    UIButton *goShoppingBtn = [UIButton bee_buttonWithTitle:@"去逛逛" andFontSize:14 andNormalColor:[UIColor grayColor] andSelectedColor:nil];
    //3.1 设置按钮的边框
    [goShoppingBtn.layer setMasksToBounds:YES];
    [goShoppingBtn.layer setCornerRadius:10];
    [goShoppingBtn.layer setBorderWidth:1];
    //3.2设置边框颜色
    [goShoppingBtn.layer setBorderColor:[UIColor grayColor].CGColor];
    [self addSubview:goShoppingBtn];
    //3.3添加按钮的点击事件
    [goShoppingBtn addTarget:self action:@selector(goToHomeVC:) forControlEvents:UIControlEventTouchUpInside];
    
    //4.设置控件约束
    [blankCautionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-80);
    }];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(blankCautionLabel.mas_top).offset(-40);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [goShoppingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(blankCautionLabel);
        make.top.equalTo(blankCautionLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(120);
    }];
}

#pragma mark -按钮的点击事件
-(void)goToHomeVC:(UIButton *)sender{
    
    //1.设置代理方法跳转到主页
    if ([_delegate respondsToSelector:@selector(goToHomeViewController)]) {
        [_delegate goToHomeViewController];
    }
}

@end
