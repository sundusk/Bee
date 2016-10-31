//
//  DQ_PayCell.h
//  Bee
//
//  Created by Apple on 16/9/9.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "DQ_BaseCell.h"

@interface DQ_PayCell : DQ_BaseCell
//选好了按钮
@property(strong,nonatomic)UIButton *payBtn;
//传到VC中
@property(strong,nonatomic)UIButton *selectedAllBtn;
//获取总价格
@property(assign,nonatomic)float totalPrice;
//改变按钮状态的ID
@property(assign,nonatomic)NSInteger buttonId;
@end
