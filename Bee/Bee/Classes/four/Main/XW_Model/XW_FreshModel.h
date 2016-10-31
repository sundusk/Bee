//
//  XW_FreshModel.h
//  Bee
//
//  Created by 9264 on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XW_FreshModel : NSObject
//名字
@property(nonatomic,copy) NSString *name;
//超市价格
@property(nonatomic,copy) NSString *market_price;
//原价
@property(nonatomic,copy) NSString *partner_price;
//规格
@property(nonatomic,copy) NSString *specifics;
//价格
@property(nonatomic,copy) NSString *price;
//数量
@property(nonatomic,copy) NSString *number;
//优惠
@property(nonatomic,copy) NSString *pm_desc;
//图片
@property(nonatomic,copy) NSString *img;
//品牌
@property(nonatomic,copy) NSString *brand_name;
//保质期
@property(nonatomic,copy) NSString *safe_day;
//负责记录自己的数量
@property (assign, nonatomic) NSInteger orderCount;


+ (instancetype)newsWithDict:(NSDictionary *)dict;
@end
/*
 {
 "data":[{"id":"id","name":"名字","store_nums":"50","sort":"1","brand_id":"品牌id","hot_degree":"热度","safe_day":"保质期","market_price":"超市价格","cid":"106","category_id":"分类id","pcid":"55","partner_price":"原价","brand_name":"爱鲜蜂","ismix":"0","cart_group_id":"0","source_id":"1","tag_ids":"5","is_del":"0","attribute":"","specifics":"规格","product_id":"产品id","dealer_id":"7951","price":"价格","number":数量,"had_pm":1,"pm_desc":"优惠","is_xf":1,"img":"图片"},
 */