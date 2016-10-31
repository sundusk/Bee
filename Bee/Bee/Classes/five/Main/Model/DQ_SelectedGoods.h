//
//  DQ_SelectedGoods.h
//  Bee
//
//  Created by Apple on 16/9/12.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XW_FreshModel.h"

@interface DQ_SelectedGoods : NSObject
@property(strong,nonatomic)NSMutableArray <XW_FreshModel *>*selectedGoodsArry;
//单例创建模型数组,全局访问
+(instancetype)sharedSelectedGoods;

@end
