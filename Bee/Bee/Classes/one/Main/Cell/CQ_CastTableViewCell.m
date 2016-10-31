//
//  CQ_CastTableViewCell.m
//  Bee
//
//  Created by 神威 on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "CQ_CastTableViewCell.h"

@implementation CQ_CastTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark -计算总价
-(void)setTotalPrice:(float)totalPrice{
    _totalPrice = totalPrice;
    _moneyLabel.text = [NSString stringWithFormat:@"%.2f",_totalPrice];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
