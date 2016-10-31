//
//  LW_OrderGoodsModel.m
//  Bee
//
//  Created by huanglinwang on 16/9/9.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "LW_OrderGoodsModel.h"

@implementation LW_OrderGoodsModel

+(instancetype)LW_OrderGoodsModelWithDict:(NSDictionary *)dict{
    
    LW_OrderGoodsModel *model = [[LW_OrderGoodsModel alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return  model;
    
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}


-(NSString *)description{
    return [NSString stringWithFormat:@"%@ - %@  -%@%zd",self.goods_price,self.img,self.name,self.goods_nums.integerValue];
}
@end
