//
//  YS_QuanCell.m
//  Bee
//
//  Created by yaoshuai on 16/9/9.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "YS_QuanCell.h"
#import "YS_QuanModel.h"
#import "UIImageView+WebCache.h"

@interface YS_QuanCell()

@property (weak, nonatomic) UIImageView *bgView;
@property (weak, nonatomic) UIView *moneyBgView;
@property (weak, nonatomic) UILabel *moneyLabel;

@property (weak, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UILabel *titleLeftSeparLabel;
@property (weak, nonatomic) UILabel *titleRightSeparLabel;

@property (weak, nonatomic) UILabel *youxiaoqiLabel;
@property (weak, nonatomic) UILabel *youxiaoqiBottomSeparLabel;
@property (weak, nonatomic) UILabel *descLabel;

@end

@implementation YS_QuanCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.contentView.backgroundColor = [UIColor bee_colorWithHex:0xf8f8f8 andAlpha:1];
        
        UIView *selectBgView = [[UIView alloc] initWithFrame:self.bounds];
        selectBgView.backgroundColor = [UIColor bee_colorWithHex:0xffffff andAlpha:1];
        self.selectedBackgroundView = selectBgView;
        
        [self setupUI];
        [self setupContraints];
    }
    return self;
}

#pragma mark - 布局界面
- (void)setupUI
{
    UIImageView *bgView = [[UIImageView alloc] init];
    UIView *moneyBgView = [[UIView alloc] init];
    UILabel *moneyLabel = [[UILabel alloc] init];
    UILabel *titleLabel = [[UILabel alloc] init];
    UILabel *titleLeftSeparLabel = [[UILabel alloc] init];
    UILabel *titleRightSeparLabel = [[UILabel alloc] init];
    UILabel *youxiaoqiLabel = [[UILabel alloc] init];
    UILabel *youxiaoqiBottomSeparLabel = [[UILabel alloc] init];
    UILabel *descLabel = [[UILabel alloc] init];
    
    [self.contentView addSubview:bgView];
    [self.contentView addSubview:moneyBgView];
    [self.contentView addSubview:moneyLabel];
    [self.contentView addSubview:titleLabel];
    [self.contentView addSubview:titleLeftSeparLabel];
    [self.contentView addSubview:titleRightSeparLabel];
    [self.contentView addSubview:youxiaoqiLabel];
    [self.contentView addSubview:youxiaoqiBottomSeparLabel];
    [self.contentView addSubview:descLabel];
    
    _bgView = bgView;
    _moneyBgView = moneyBgView;
    _moneyLabel = moneyLabel;
    _titleLabel = titleLabel;
    _titleLeftSeparLabel = titleLeftSeparLabel;
    _titleRightSeparLabel = titleRightSeparLabel;
    _youxiaoqiLabel = youxiaoqiLabel;
    _youxiaoqiBottomSeparLabel = youxiaoqiBottomSeparLabel;
    _descLabel = descLabel;
    
    // 设置控件属性
    _moneyLabel.font = [UIFont systemFontOfSize:16.0f];
    _moneyLabel.textColor = [UIColor whiteColor];
    
    _moneyBgView.layer.cornerRadius = 25;
    _moneyBgView.layer.masksToBounds = YES;
    
    _titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLeftSeparLabel.backgroundColor = [UIColor grayColor];
    _titleRightSeparLabel.backgroundColor = [UIColor grayColor];
    
    _youxiaoqiLabel.font = [UIFont systemFontOfSize:13.0f];
    _youxiaoqiLabel.textColor = [UIColor grayColor];
    _youxiaoqiLabel.numberOfLines = 0;
    _youxiaoqiBottomSeparLabel.backgroundColor = [UIColor grayColor];
    
    _descLabel.font = [UIFont systemFontOfSize:12.0f];
    _descLabel.textColor = [UIColor grayColor];
    _descLabel.numberOfLines = 0;
}

- (void)setupContraints
{
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(5);
        make.bottom.offset(-5);
    }];
    [_moneyBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(20);
        make.width.height.offset(50);
    }];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_moneyBgView);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.centerX.equalTo(self.contentView).offset(45);
    }];
    [_titleLeftSeparLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleLabel);
        make.left.equalTo(_moneyBgView.mas_right).offset(30);
        make.right.equalTo(_titleLabel.mas_left).offset(-10);
        make.height.mas_equalTo(1);
    }];
    [_titleRightSeparLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleLabel);
        make.left.equalTo(_titleLabel.mas_right).offset(10);
        make.right.offset(-10);
        make.height.equalTo(_titleLeftSeparLabel);
    }];
    [_youxiaoqiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(5);
        make.centerX.equalTo(_titleLabel);
    }];
    [_youxiaoqiBottomSeparLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_youxiaoqiLabel.mas_bottom).offset(5);
        make.left.right.equalTo(_youxiaoqiLabel);
        make.height.mas_equalTo(1);
    }];
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_youxiaoqiBottomSeparLabel.mas_bottom).offset(5);
        make.left.equalTo(_titleLeftSeparLabel).offset(10);
        make.right.equalTo(_titleRightSeparLabel).offset(-10);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.bottom.equalTo(_descLabel).offset(5);
    }];
}

- (void)setQuanModel:(YS_QuanModel *)quanModel
{
    _quanModel = quanModel;
    
    CGFloat fen = quanModel.value = (NSInteger)quanModel.value;
    NSString *moneyStr = fen > 0 ? [NSString stringWithFormat:@"$%.1f",quanModel.value]:[NSString stringWithFormat:@"$%.0f",quanModel.value];
    _moneyLabel.text = moneyStr;
    _titleLabel.text = quanModel.name;
    _youxiaoqiLabel.text = [NSString stringWithFormat:@"有效期：%@至%@",quanModel.start_time,quanModel.end_time];
    _descLabel.text = quanModel.desc;
    
    if(quanModel.is_userd)// 已使用，背景灰图、钱灰图
    {
        _bgView.image = [UIImage imageNamed:@"v2_coupon_gray"];
        _moneyBgView.backgroundColor = [UIColor lightGrayColor];
    }
    else// 未使用，背景黄图、钱黄图
    {
        _bgView.image = [UIImage imageNamed:@"v2_coupon_yellow"];
        _moneyBgView.backgroundColor = [UIColor orangeColor];
    }
}

@end
