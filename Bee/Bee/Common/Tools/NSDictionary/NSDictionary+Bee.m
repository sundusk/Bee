//
//  NSDictionary+YS.m
//  MeiTuan
//
//  Created by yaoshuai on 16/8/7.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "NSDictionary+Bee.h"

@implementation NSDictionary (Bee)

// 集合中有中文打印Unicode编码，但字符串中有中文依旧打印中文，所以重写此方法
- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    
    [strM appendString:@"}\n"];
    
    return strM.copy;
}

@end
