//
//  YS_QuanModel.h
//  Bee
//
//  Created by yaoshuai on 16/9/9.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YS_QuanModel : NSObject

/*
 {
 "id": "优惠券id",
 "card_pwd": "10c0c3e8",
 "start_time": "开始时间",
 "end_time": "结束时间",
 "value": "价值",
 "tid": "1113",
 "is_userd": "是否使用",
 "status": 状态,
 "true_end_time": "过期日期",
 "name": "名称",
 "point": "0",
 "type": "类型",
 "order_limit_money": "订单要求",
 "description": "描述",
 "free_freight": "0",
 "city": "2",
 "platform": "平台",
 "bind_type": "品牌类型",
 "user_group": "组",
 "alert_time": "提醒时间",
 "total_num": "30000"
 }
 
 */

@property (copy, nonatomic) NSString *id;

// 有效期
@property (copy, nonatomic) NSString *start_time;
@property (copy, nonatomic) NSString *end_time;

// 价格
@property (assign, nonatomic) CGFloat value;

// Yes:已使用；No:未使用
@property (assign, nonatomic) BOOL is_userd;
// 标题
@property (copy, nonatomic) NSString *name;

// 描述
@property (copy, nonatomic) NSString *desc;

@end