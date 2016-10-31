//
//  YQ_SystemMessageModel.h
//  Bee
//
//  Created by 黄跃奇 on 16/9/9.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YQ_SystemMessageModel : NSObject

/**
 *  信息标题
 */
@property(copy, nonatomic) NSString *title;

/**
 *  信息内容
 */
@property(copy, nonatomic) NSString *content;

@end

/*
 
 {
	noticy = 1;
	content = 站内信：
 亲爱的用户：
 您好，北京即日起爱鲜蜂首次开启“0元起送”新时代，全场订单0元起送，当日22点前收货不满30元收取5元运费，22点后不满50元收取10元运费，新鲜预订商品下单不满30元收取5元运费，满30元免运费。
 ;
	city = 2;
	id = 3;
	send_time = 2015-09-24 15:30:00;
	title = “0元起送”新时代;
	link = ;
	type = 0;
 }
 
 */


