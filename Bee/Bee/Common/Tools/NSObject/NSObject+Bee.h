//
//  NSObject+YS.h
//  ZFBCollectionView
//
//  Created by yaoshuai on 16/7/13.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Bee)

/**
 *  字典转模型
 *
 *  @param className  模型类名称
 *  @param dictionary 数据字典
 *
 *  @return 根据字典生成的模型类
 */
+ (instancetype)bee_objWithClassName:(NSString *)className andDictionary:(NSDictionary *)dictionary;

@end
