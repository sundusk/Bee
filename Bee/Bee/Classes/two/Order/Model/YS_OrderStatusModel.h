//
//  YS_OrderStatusModel.h
//  Bee
//
//  Created by yaoshuai on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YS_OrderStatusModel : NSObject

@property (copy, nonatomic) NSString *time;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subtitle;

// 控制按钮
@property (assign, nonatomic) BOOL selected;

// 1：第1个，1000：最后一个，其他：正常
@property (assign, nonatomic) NSInteger idxType;

@end
