//
//  YS_FeedbackVC.m
//  Bee
//
//  Created by yaoshuai on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "YS_FeedbackVC.h"

@interface YS_FeedbackVC ()

@property (weak, nonatomic) UITextView *opinionV;

@end

@implementation YS_FeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"意见反馈";
    [self setupUI];
}

#pragma mark - 布局界面
- (void)setupUI
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendMsg:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UILabel *awakeLbl = [UILabel bee_labelWithText:@"你的批评和建议能帮助我们更好的完善产品，请留下你的宝贵意见！" andColor:[UIColor blackColor] andFontSize:14.0f];
    [self.view addSubview:awakeLbl];
    
    UITextView *optionV = [[UITextView alloc] init];
    [self.view addSubview:optionV];
    _opinionV = optionV;
    
    // 设置控件属性
    awakeLbl.numberOfLines = 0;
    optionV.textColor = [UIColor grayColor];
    optionV.font = [UIFont systemFontOfSize:14.0f];
    optionV.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    // 布局子控件
    [awakeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.offset(10);
        make.right.offset(-10);
    }];
    [optionV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(awakeLbl);
        make.top.equalTo(awakeLbl.mas_bottom).offset(10);
        make.height.mas_equalTo(150);
    }];
}
- (void)sendMsg:(UIButton *)sender
{
    NSLog(@"发送");
}
@end