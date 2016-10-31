//
//  DQ_PayCell.m
//  Bee
//
//  Created by Apple on 16/9/9.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "DQ_PayCell.h"
@interface DQ_PayCell()

//总价
@property(weak,nonatomic)UILabel *totalPriceLable;
@end

@implementation DQ_PayCell

#pragma mark -计算总价
-(void)setTotalPrice:(float)totalPrice{
    _totalPrice = totalPrice;
    _totalPriceLable.text = [NSString stringWithFormat:@"%.2f",_totalPrice];
}

#pragma mark -搭建界面
-(void)setupUI{
    //全选按钮
    _selectedAllBtn = [[UIButton alloc]init];
    [_selectedAllBtn setImage:[UIImage imageNamed:@"v2_selected"] forState:UIControlStateNormal];
    [_selectedAllBtn setImage:[UIImage imageNamed:@"v2_noselected"] forState:UIControlStateSelected];
    [_selectedAllBtn sizeToFit];
    [_selectedAllBtn addTarget:self action:@selector(selectedAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_selectedAllBtn];
    //全选字段
    UILabel *selectedAllLabel = [UILabel bee_labelWithText:@"全选" andColor:[UIColor blackColor] andFontSize:13];
    [self.contentView addSubview:selectedAllLabel];
    //总价字段
    UILabel *totalPriceLabel = [UILabel bee_labelWithText:[NSString stringWithFormat:@"共 ¥2"] andColor:[UIColor redColor] andFontSize:11];
    [self.contentView addSubview:totalPriceLabel];
    _totalPriceLable = totalPriceLabel;
    //准备付款按钮
    _payBtn = [[UIButton alloc]init];
    _payBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_payBtn setTitle:@"选好了" forState:UIControlStateNormal];
    [_payBtn setBackgroundImage:[UIImage imageNamed:@"v2_coupon_verify_normal"] forState:UIControlStateNormal];

    [_payBtn setTitle:@"满 ¥ 0起送" forState:UIControlStateSelected];
    [_payBtn setBackgroundImage:[UIImage imageNamed:@"grey1"] forState:UIControlStateSelected];

    [self.contentView addSubview:_payBtn];
    [_payBtn addTarget:self action:@selector(goToPayVC) forControlEvents:UIControlEventTouchUpInside];
    //设置约束
    [_selectedAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [selectedAllLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_selectedAllBtn);
        make.left.equalTo(_selectedAllBtn.mas_right).offset(20);
    }];
    
    [totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(selectedAllLabel);
        make.left.equalTo(selectedAllLabel.mas_right).offset(20);
    }];
    
    [_payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    //给tableviewcell设置向上的约束
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(_payBtn.mas_bottom);
    }];
    
}

-(void)goToPayVC{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"goToPayVC" object:self];
}

#pragma mark -监听按钮点击事件
-(void)selectedAllBtnClick:(UIButton *)button{
    button.selected = !button.selected;
    //通知,将自己的选中状态传递出去
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectedAllBtnClick" object:button];
    if (_selectedAllBtn.selected == YES) {
        self.payBtn.selected = YES;
    }else{
        self.payBtn.selected = NO;
    }
}
@end
