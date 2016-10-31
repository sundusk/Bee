//
//  CQ_PayTableViewCell.h
//  Bee
//
//  Created by 神威 on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CQ_PayTableViewCell : UITableViewCell
/**
 *  支付按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *payButton;
/**
 *  支付名称
 */
@property (weak, nonatomic) IBOutlet UILabel *payNameLabel;
/**
 *  支付图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *payImageView;

@end
