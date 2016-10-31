//
//  CQ_CastTableViewCell.h
//  Bee
//
//  Created by 神威 on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CQ_CastTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *castNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
//获取总价格
@property(assign,nonatomic)float totalPrice;
@end
