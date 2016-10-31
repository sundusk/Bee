//
//  CQ_CommodityTableViewCell.h
//  Bee
//
//  Created by 神威 on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XW_FreshModel.h"

@interface CQ_CommodityTableViewCell : UITableViewCell
/**
 *  模型
 */
@property(strong,nonatomic)XW_FreshModel *model;
/**
 *  负责记录自己的数量
 */
@property (assign, nonatomic) NSInteger orderCount;

@end
