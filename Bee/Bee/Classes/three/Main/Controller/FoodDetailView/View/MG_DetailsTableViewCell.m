//
//  MG_DetailsTableViewCell.m
//  Bee
//
//  Created by apple on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "MG_DetailsTableViewCell.h"

@interface MG_DetailsTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *market_priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *partner_priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *brand_nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *specificsLabel;
@property (weak, nonatomic) IBOutlet UILabel *safe_dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pm_descView;

@end
@implementation MG_DetailsTableViewCell
+ (instancetype)detailsTableViewCell{
    return [[NSBundle mainBundle] loadNibNamed:@"DetailSTableViewCell" owner:nil options:nil].lastObject;
    
}

- (void)setXWmodel:(XW_FreshModel *)XWmodel{
    _XWmodel = XWmodel;
    _nameLabel.text = XWmodel.name;
    _market_priceLabel.text = [NSString stringWithFormat:@"￥%@",XWmodel.market_price];
    _partner_priceLabel.text = [NSString stringWithFormat:@"￥%@",XWmodel.partner_price];
    _brand_nameLabel.text = XWmodel.brand_name;
    _specificsLabel.text = XWmodel.specifics;
    _safe_dayLabel.text = [NSString stringWithFormat:@"%@天",XWmodel.safe_day];
    if ([XWmodel.pm_desc  isEqual: @"买一赠一"]) {
        _pm_descView.image = [UIImage imageNamed:@"buyOne.png"];
    }
}
- (void)setYQModel:(XW_FreshModel *)YQModel{
    _YQModel = YQModel;
    _nameLabel.text = YQModel.name;
    _market_priceLabel.text = [NSString stringWithFormat:@"￥%@",YQModel.market_price];
    _partner_priceLabel.text = [NSString stringWithFormat:@"￥%@",YQModel.partner_price];
    _brand_nameLabel.text = YQModel.brand_name;
    _specificsLabel.text = YQModel.specifics;
    _safe_dayLabel.text = [NSString stringWithFormat:@"%@天",YQModel.safe_day];
    if ([YQModel.pm_desc  isEqual: @"买一赠一"]) {
        _pm_descView.image = [UIImage imageNamed:@"buyOne.png"];
    }
}
@end
