//
//  CQ_CommodityTableViewCell.m
//  Bee
//
//  Created by 神威 on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "CQ_CommodityTableViewCell.h"
 
@interface CQ_CommodityTableViewCell()
/**
 *  商品名称
 */
@property (weak, nonatomic) IBOutlet UILabel *commoditNameLabel;
/**
 *  商品价格
 */
@property (weak, nonatomic) IBOutlet UILabel *prieLabel;
/**
 *  商品总价
 */
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
/**
 *  商品数量
 */
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end
@implementation CQ_CommodityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}




- (void)setModel:(XW_FreshModel *)model{
    _commoditNameLabel.text = model.name;
    _totalPriceLabel.text = model.partner_price;
    _orderCount = model.orderCount;
    _numLabel.text = [NSString stringWithFormat:@"%ld",(long)_orderCount];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
