//
//  LW_OrderModel.h
//  Bee
//
//  Created by huanglinwang on 16/9/9.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LW_OrderGoodsModel;
@interface LW_OrderModel : NSObject
//最后更新时间
@property(nonatomic,copy)NSString *lastUpdateTime;
//完成状态
@property(nonatomic,copy)NSString *textStatus;
//订单物品列表 - 商品个数.count - 价格- 数量 -计算总价
@property(nonatomic,copy)NSArray<LW_OrderGoodsModel *> *order_goods;
//状态时间线
@property(nonatomic,copy)NSArray<NSDictionary *> *status_timeline;

+(instancetype)lw_OrderModel:(NSDictionary *)dict;

@end
