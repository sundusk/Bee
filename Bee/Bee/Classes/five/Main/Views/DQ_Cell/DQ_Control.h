//
//  DQ_Control.h
//  Bee
//
//  Created by Apple on 16/9/11.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DQ_Control : UIControl
//记录模型数量
@property (assign, nonatomic) NSInteger count;
//判断增减
@property (assign, nonatomic) BOOL isIncrease;
//类方法创建
+(instancetype)Control;
@end
