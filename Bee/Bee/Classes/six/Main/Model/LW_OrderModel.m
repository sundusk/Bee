//
//  LW_OrderModel.m
//  Bee
//
//  Created by huanglinwang on 16/9/9.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "LW_OrderModel.h"
#import "LW_OrderGoodsModel.h"
@implementation LW_OrderModel

+(instancetype)lw_OrderModel:(NSDictionary *)dict{
    LW_OrderModel *model = [[LW_OrderModel alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}


-(void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if ([key isEqual: @"order_goods"]) {
        
        NSMutableArray *arrayM = [NSMutableArray array];
        [value enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                LW_OrderGoodsModel *model  = [[LW_OrderGoodsModel alloc] init];
//                NSLog(@"%@",[obj class]);
                [model setValuesForKeysWithDictionary:obj];
                [arrayM addObject:model];
            }];
        }];
        
        [super setValue:arrayM.copy forKey:key];
    }
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@ -%@ -%zd -%@ - %@",self.lastUpdateTime,self.textStatus,self.order_goods.count,self.status_timeline,self.order_goods];
}

@end
