//
//  NSObject+YS.m
//  ZFBCollectionView
//
//  Created by yaoshuai on 16/7/13.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "NSObject+Bee.h"

@implementation NSObject (Bee)

+ (instancetype)bee_objWithClassName:(NSString *)className andDictionary:(NSDictionary *)dictionary
{
    Class class = NSClassFromString(className);
    NSAssert(class, @"名为%@的类不存在",className);
    NSObject *obj = [[class alloc] init];
    [obj setValuesForKeysWithDictionary:dictionary];
    return obj;
}

@end