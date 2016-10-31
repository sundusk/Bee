//
//  DQ_GoodsCell.h
//  Bee
//
//  Created by Apple on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DQ_BaseCell.h"
#import "DQ_AddressModel.h"

@interface DQ_GoodsCell : DQ_BaseCell
//回调的地址模型
@property(strong,nonatomic)DQ_AddressModel *addressModel;

@end
