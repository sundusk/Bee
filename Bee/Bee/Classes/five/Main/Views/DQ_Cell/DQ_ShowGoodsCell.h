//
//  DQ_ShowGoodsCell.h
//  Bee
//
//  Created by Apple on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "DQ_BaseCell.h"
#import "XW_FreshModel.h"

@interface DQ_ShowGoodsCell : DQ_BaseCell
//传入的模型
@property(strong,nonatomic)XW_FreshModel *model;
//选中的按钮
@property(weak,nonatomic)UIButton *selectedBtn;
@end
