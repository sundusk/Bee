//
//  NSArray+YS.h
//  ZFBCollectionView
//
//  Created by yaoshuai on 16/7/13.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Bee)

/**
 *  根据URL和模型类名称生成模型类数组(NSArray)
 *
 *  @param url            资源的URL
 *  @param modelClassName 模型类的名称
 *
 *  @return 根据URL和模型类名称生成的模型类数组(NSArray)
 */
+ (instancetype)bee_arrayWithURL:(NSURL *)url andModelClassName:(NSString *)modelClassName;

@end
