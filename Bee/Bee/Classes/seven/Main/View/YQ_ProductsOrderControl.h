//
//  YQ_ProductsOrderControl.h
//  Bee
//
//  Created by 黄跃奇 on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQ_ProductsOrderControl : UIControl

/**
 *  记录产品数量
 */
@property(assign, nonatomic) NSInteger count;

/**
 *  产品订单增加还是减少
 */
@property(assign, nonatomic) BOOL isIncrease;

/**
 *  动画的起始点
 */
@property(assign, nonatomic) CGPoint startP;



/**
 *  快速创建视图的方法
 */
+ (instancetype)productsOrderControl;


@end
