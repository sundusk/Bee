//
//  LW_OrderGoodsModel.h
//  Bee
//
//  Created by huanglinwang on 16/9/9.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LW_OrderGoodsModel.h"

@interface LW_OrderGoodsModel : NSObject
//价格
@property(nonatomic,copy)NSString *goods_price;
@property(nonatomic,copy)NSString *img;
@property(nonatomic,copy)NSString *name;
//数量
@property(nonatomic,copy)NSString *goods_nums;
+(instancetype)LW_OrderGoodsModelWithDict:(NSDictionary *)dict;

@end
