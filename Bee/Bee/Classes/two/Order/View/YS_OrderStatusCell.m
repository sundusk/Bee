//
//  YS_OrderStatusCell.m
//  Bee
//
//  Created by yaoshuai on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "YS_OrderStatusCell.h"
#import "YS_OrderStatusModel.h"

@interface YS_OrderStatusCell()

@property (weak, nonatomic) UILabel *timeLabel;
@property (weak, nonatomic) UIButton *cycleBtn;
@property (weak, nonatomic) UILabel *lineLabel;
@property (weak, nonatomic) UILabel *titleLabel;
@property (copy, nonatomic) UILabel *subtitleLabel;
@property (weak, nonatomic) UILabel *bottomLineLabel;

@end

@implementation YS_OrderStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setupControllers];
        [self setupUIConstraint];
    }
    return self;
}

#pragma mark - 布局界面
- (void)setupControllers
{
    UILabel *timeLabel = [UILabel bee_labelWithText:@"" andColor:[UIColor grayColor] andFontSize:12.0f];
    UILabel *titleLabel = [UILabel bee_labelWithText:@"" andColor:[UIColor blackColor] andFontSize:14.0f];
    UILabel *subtitleLabel = [UILabel bee_labelWithText:@"" andColor:[UIColor grayColor] andFontSize:12.0f];
    
    [self.contentView addSubview:timeLabel];
    [self.contentView addSubview:titleLabel];
    [self.contentView addSubview:subtitleLabel];
    
    _timeLabel = timeLabel;
    _titleLabel = titleLabel;
    _subtitleLabel = subtitleLabel;
    
    UILabel *lineLabel = [[UILabel alloc] init];
    UILabel *bottomLineLabel = [[UILabel alloc] init];
    UIButton *cycleBtn = [[UIButton alloc] init];
    
    [self.contentView addSubview:lineLabel];
    [self.contentView addSubview:bottomLineLabel];
    [self.contentView addSubview:cycleBtn];
    
    _lineLabel = lineLabel;
    _bottomLineLabel = bottomLineLabel;
    _cycleBtn = cycleBtn;
    
    // 设置控件属性
    _subtitleLabel.numberOfLines = 0;
    _cycleBtn.userInteractionEnabled = NO;
    _bottomLineLabel.backgroundColor = [UIColor darkGrayColor];
    _lineLabel.backgroundColor = [UIColor grayColor];
}

- (void)setupUIConstraint
{
    // 时间
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
    }];
    // 圆形按钮
    [_cycleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(15);
        make.top.equalTo(_timeLabel).offset(-2);
        make.left.equalTo(_timeLabel.mas_right).offset(10);
    }];
    // 标题
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cycleBtn);
        make.left.equalTo(_cycleBtn.mas_right).offset(15);
    }];
    // 副标题
    [_subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(15);
        make.left.equalTo(_titleLabel);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    // 底部的线
    [_bottomLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.equalTo(_titleLabel);
        make.right.equalTo(self.contentView);
        make.top.equalTo(_subtitleLabel.mas_bottom).offset(2);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(_bottomLineLabel).offset(10);
    }];
}

- (void)setOrderStatusModel:(YS_OrderStatusModel *)orderStatusModel
{
    _orderStatusModel = orderStatusModel;
    
    _timeLabel.text = orderStatusModel.time;
    _titleLabel.text = orderStatusModel.title;
    _subtitleLabel.text = orderStatusModel.subtitle;
    
    NSString *cycleBtnString = orderStatusModel.selected ? @"order_yellowMark" :@"order_grayMark";
    [_cycleBtn setBackgroundImage:[UIImage imageNamed:cycleBtnString] forState:UIControlStateNormal];
    
    if(orderStatusModel.idxType == 1)// 第一个
    {
        [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_cycleBtn);
            make.width.equalTo(@2);
            make.top.equalTo(_cycleBtn.mas_bottom);
            make.bottom.equalTo(self.contentView);
        }];
    }
    else if (orderStatusModel.idxType == 1000)// 最后一个
    {
        [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_cycleBtn);
            make.width.equalTo(@2);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(_cycleBtn.mas_top);
        }];
    }
    else// 中间的cell
    {
        [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_cycleBtn);
            make.width.equalTo(@2);
            make.top.bottom.equalTo(self.contentView);
        }];
    }
}

@end
