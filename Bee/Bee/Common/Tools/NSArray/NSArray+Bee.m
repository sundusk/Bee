//
//  NSArray+YS.m
//  ZFBCollectionView
//
//  Created by yaoshuai on 16/7/13.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "NSArray+Bee.h"
#import "NSObject+Bee.h"

@implementation NSArray (Bee)

+ (instancetype)bee_arrayWithURL:(NSURL *)url andModelClassName:(NSString *)modelClassName
{
    NSArray *arr = [NSArray arrayWithContentsOfURL:url];
    NSMutableArray *marr = [NSMutableArray arrayWithCapacity:arr.count];
    for (NSDictionary *dict in arr) {
        [marr addObject:[NSObject bee_objWithClassName:modelClassName andDictionary:dict]];
    }
    return marr.copy;
}

// 集合中有中文打印Unicode编码，但字符串中有中文依旧打印中文，所以重写此方法
- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSString *lastStr = idx == (self.count - 1) ? @"" : @",";
        
        [strM appendFormat:@"\t%@%@\n", obj,lastStr];
    }];
    
    [strM appendString:@")"];
    
    return strM.copy;
}

@end
