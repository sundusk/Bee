//
//  YQ_ProductsCell.m
//  Bee
//
//  Created by 黄跃奇 on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "YQ_ProductsCell.h"
#import "XW_FreshModel.h"
#import "UIImageView+WebCache.h"
#import "YQ_ProductsOrderControl.h"

@interface YQ_ProductsCell ()


/**
 *  产品图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *imgImageView;

/**
 *  动画图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *animImageView;

/**
 *  产品名称
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

/**
 *  产品规格
 */
@property (weak, nonatomic) IBOutlet UILabel *specificsLabel;

/**
 *  产品原价
 */
@property (weak, nonatomic) IBOutlet UILabel *market_priceLabel;

/**
 *  产品优惠价格
 */
@property (weak, nonatomic) IBOutlet UILabel *partner_priceLabel;

/**
 *  买一赠送
 */
@property (weak, nonatomic) IBOutlet UIImageView *pm_descImageView;

/**
 *  负责显示产品订单数量的控件
 */
@property(weak, nonatomic) YQ_ProductsOrderControl *orderControl;

@end

@implementation YQ_ProductsCell

- (void)setProductsModel:(XW_FreshModel *)productsModel {
    
    _productsModel = productsModel;
    
    self.nameLabel.text = productsModel.name;
    self.specificsLabel.text = productsModel.specifics;
    self.market_priceLabel.text = [NSString stringWithFormat:@"$%@", productsModel.market_price];
    self.partner_priceLabel.text = [NSString stringWithFormat:@"$%@", productsModel.partner_price];
    
    if ([productsModel.pm_desc isEqualToString:@"买一赠一"]) {
        self.pm_descImageView.image = [UIImage imageNamed:@"buyOne.png"];
    }
    
    [self.imgImageView sd_setImageWithURL:[NSURL URLWithString:productsModel.img] placeholderImage:[UIImage imageNamed:@"v2_placeholder_square"]];
    
    [self.animImageView sd_setImageWithURL:[NSURL URLWithString:productsModel.img] placeholderImage:[UIImage imageNamed:@"v2_placeholder_square"]];
    
    //设置数量信息
    _orderControl.count = productsModel.orderCount;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupUI];
    
}

#pragma mark - 设置UI界面
- (void)setupUI {
    
    //控制产品订单数量的界面
    YQ_ProductsOrderControl *orderControl = [YQ_ProductsOrderControl productsOrderControl];
//    orderControl.count
    //监听数量控制的值改变事件
    [orderControl addTarget:self action:@selector(orderControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.contentView addSubview:orderControl];
    
    [orderControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-5);
        
        //控制视图的宽高
        make.size.mas_equalTo(CGSizeMake(96, 27));
        
    }];
    _orderControl = orderControl;
}

#pragma mark - 监听数量控制的值改变事件
- (void)orderControlValueChanged:(YQ_ProductsOrderControl *)sender {
    
    //1. 将接收到的订单数量信息设置给自己的模型
    self.productsModel.orderCount = sender.count;
    
    //2. 判断是增加还是减少
    if (sender.isIncrease) {
        
        if ([_delegate respondsToSelector:@selector(productsCell:didFinishIncreseProducts:andStartPoint:animImageView:)]) {
            
            [_delegate productsCell:self didFinishIncreseProducts:self.productsModel andStartPoint:sender.startP animImageView:self.animImageView];
        }
    } else {
        if ([_delegate respondsToSelector:@selector(productsCell:didFinishReduceProducts:)]) {
            [_delegate productsCell:self didFinishReduceProducts:self.productsModel];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
