//
//  MG_HeaderView.m
//  Bee
//
//  Created by yaoshuai on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "MG_HeaderView.h"
#import "UIImageView+WebCache.h"
#import "LW_LoginVC.h"

@interface MG_HeaderView()

@property (weak, nonatomic) UIImageView *avatorImgV;
@property (weak, nonatomic) UILabel *mobileLabel;
@property (weak, nonatomic) UIButton *settingBtn;

@end

@implementation MG_HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI
{
    UIImageView *topBGView = [[UIImageView alloc] initWithFrame:self.bounds];
    topBGView.image = [UIImage imageNamed:@"v2_my_avatar_bg"];
    [self addSubview:topBGView];
    
    UIImageView *avatorImgV = [[UIImageView alloc] init];
    avatorImgV.image = [UIImage imageNamed:@"v2_my_avatar"];
    avatorImgV.userInteractionEnabled = YES;
    [topBGView addSubview:avatorImgV];
    _avatorImgV = avatorImgV;
    
    UIButton *settingBtn = [[UIButton alloc] init];
    [settingBtn setBackgroundImage:[UIImage imageNamed:@"v2_my_settings_icon"] forState:UIControlStateNormal];
    [topBGView addSubview:settingBtn];
    _settingBtn = settingBtn;
    
    UILabel *mobileLabel = [UILabel bee_labelWithText:@"13134334544" andColor:[UIColor whiteColor] andFontSize:16.0f];
    [topBGView addSubview:mobileLabel];
    _mobileLabel = mobileLabel;
    mobileLabel.text = [LW_LoginVC phoneNum];
    
    // 布局子控件
    [topBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(150);
    }];
    [avatorImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.centerX.offset(0);
        make.width.height.offset(80);
    }];
    [settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(avatorImgV);
        make.right.offset(-20);
    }];
    [mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(avatorImgV.mas_bottom).offset(15);
        make.centerX.offset(0);
    }];
}

@end