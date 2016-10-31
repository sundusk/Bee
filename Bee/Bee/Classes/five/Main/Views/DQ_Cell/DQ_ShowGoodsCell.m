//
//  DQ_ShowGoodsCell.m
//  Bee
//
//  Created by Apple on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "DQ_ShowGoodsCell.h"
#import "UIImageView+WebCache.h"
#import "YQ_ProductsOrderControl.h"
@interface DQ_ShowGoodsCell()
@property(strong,nonatomic)UIButton *button;
//子控件全局化
@property(weak,nonatomic)UIImageView *imageV;
@property(weak,nonatomic)UILabel *categoryLabel;
@property(weak,nonatomic)UILabel *priceLabel;
@property(weak,nonatomic)YQ_ProductsOrderControl *orderControl;

@end

@implementation DQ_ShowGoodsCell

#pragma mark -填充子控件
-(void)setModel:(XW_FreshModel *)model{
    _model = model;
    [_imageV sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"v2_common_footer"]];
    _categoryLabel.text = model.name;
    _priceLabel.text = model.partner_price;
    _orderControl.count = model.orderCount;
}

#pragma mark - 监听数量改变的事件
- (void)orderControlValueChanged:(YQ_ProductsOrderControl *)sender {
    // 1.将接收的数量信息,设置给自己的模型!
    _model.orderCount = sender.count;
    //2.搞清楚,是增加还是减少
    if (sender.isIncrease) {
        //模型数量加减,判断是否为0,从模型数组中移除
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AddGoods" object:_model];
        
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReduceGoods" object:_model];
    }
    
    
}

#pragma mark -搭建界面
-(void)setupUI{
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeButtonState:) name:@"selectedAllBtnClick" object:nil];
    //选中按钮
    _button = [[UIButton alloc]init];
    [_button setImage:[UIImage imageNamed:@"v2_selected"] forState:UIControlStateNormal];
    [_button setImage:[UIImage imageNamed:@"v2_noselected"] forState:UIControlStateSelected];
    [_button sizeToFit];
    [self.contentView addSubview:_button];
    _selectedBtn = _button;
    //点击事件
    [_button addTarget:self action:@selector(selectedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //商品图片
    UIImageView *imageV = [[UIImageView alloc]init];
    imageV.backgroundColor = [UIColor redColor];
    imageV.contentMode = UIViewContentModeScaleAspectFill;
    [imageV sizeToFit];
    [self.contentView addSubview:imageV];
    _imageV = imageV;
    //精选label
    UILabel *meticulousSelected = [UILabel bee_labelWithText:@"精选" andColor:[UIColor redColor] andFontSize:12];
    [self.contentView addSubview:meticulousSelected];
    //商品分类
    UILabel *categoryLabel = [UILabel bee_labelWithText:nil andColor:[UIColor lightGrayColor] andFontSize:12];
    [self.contentView addSubview:categoryLabel];
    _categoryLabel = categoryLabel;
    //价格
    UILabel *priceLabel = [UILabel bee_labelWithText:nil andColor:[UIColor lightGrayColor] andFontSize:12];
    [self.contentView addSubview:priceLabel];
    _priceLabel = priceLabel;
    
    //数量加减,自定义control类描述加减,设置值改变事件
    YQ_ProductsOrderControl *orderControl = [YQ_ProductsOrderControl productsOrderControl];
    _orderControl = orderControl;
    
    // 监听数量控件的值改变事件
    [orderControl addTarget:self action:@selector(orderControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:orderControl];
    
    //设置约束
    
    [orderControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(96, 27));
    }];

    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(20);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_button);
        make.left.equalTo(_button.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(30, 60));
    }];
    
    [meticulousSelected mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageV);
        make.left.equalTo(imageV.mas_right).offset(40);
    }];
    
    [categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(meticulousSelected);
        make.left.equalTo(meticulousSelected.mas_right).offset(2);
    }];
    
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(meticulousSelected);
        make.bottom.equalTo(imageV).offset(-8);
    }];
    
    //给tableviewcell设置向上的约束
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(imageV.mas_bottom).offset(8);
    }];
    
}

#pragma mark -通知
-(void)changeButtonState:(NSNotification *)notification{
    UIButton *selectedAllBtn = notification.object;
    //判断全选按钮的状态
    if (selectedAllBtn.selected == YES) {
        _button.selected = YES;
    }else{
        _button.selected = NO;
    }
}

#pragma mark -点击事件
-(void)selectedBtnClick:(UIButton *)button{
    //改变按钮的选中状态
    button.selected = !button.selected;
    //通知传递按钮状态
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectedBtnClick" object:self];
}

#pragma mark - 移除通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
