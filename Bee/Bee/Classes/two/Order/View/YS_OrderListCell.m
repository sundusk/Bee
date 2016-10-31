//
//  YS_OrderListCell.m
//  Bee
//
//  Created by yaoshuai on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "YS_OrderListCell.h"
#import "YS_OrderModel.h"

@interface YS_OrderListCell()
{
    NSArray<UIImage *> *_imgArray;
}

@property (weak, nonatomic) UILabel *timeLabel;
@property (weak, nonatomic) UILabel *stateLabel;
@property (weak, nonatomic) UILabel *countLabel;
@property (weak, nonatomic) UILabel *moneyLabel;
@property (weak, nonatomic) UIButton *fuliBtn;

@end

@implementation YS_OrderListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self setupUI];
    }
    return self;
}

#pragma mark - 布局界面
- (void)setupUI
{
    UILabel *timeLabel = [UILabel bee_labelWithText:@"2015-11-21 14:51:09" andColor:[UIColor blackColor] andFontSize:14.0f];
    UILabel *stateLabel = [UILabel bee_labelWithText:@"已完成" andColor:[UIColor redColor] andFontSize:14.0f];
    UILabel *countLabel = [UILabel bee_labelWithText:@"共7件商品" andColor:[UIColor grayColor] andFontSize:14.0f];
    UILabel *moneyLabel = [UILabel bee_labelWithText:@"实付：$42.20" andColor:[UIColor grayColor] andFontSize:14.0f];
    UIButton *fuliBtn = [UIButton bee_buttonWithTitle:@"发福利" andFontSize:14.0f andNormalColor:[UIColor orangeColor] andSelectedColor:[UIColor yellowColor]];
    
    [self.contentView addSubview:timeLabel];
    [self.contentView addSubview:stateLabel];
    [self.contentView addSubview:countLabel];
    [self.contentView addSubview:moneyLabel];
    [self.contentView addSubview:fuliBtn];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [fuliBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
}

- (void)setOrderModel:(YS_OrderModel *)orderModel
{
    _orderModel = orderModel;
    
    _timeLabel.text = orderModel.time;
    _stateLabel.text = orderModel.state;
    _countLabel.text = orderModel.count;
    _moneyLabel.text = orderModel.money;
}

@end
