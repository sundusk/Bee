//
//  NSObject+Coder.m
//  工具包-OC
//
//  Created by yaoshuai on 16/8/13.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "NSObject+Coder.h"
#import <objc/runtime.h>

@implementation NSObject (Coder)

//解档规则设置
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [self init]) {
        unsigned int count = 0;
        Ivar *ivar = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            Ivar iva = ivar[i];
            const char *name = ivar_getName(iva);
            NSString *strName = [NSString stringWithUTF8String:name];
            id value = [decoder decodeObjectForKey:strName];
            [self setValue:value forKey:strName];
        }
        free(ivar);
    }
    return self;
}

//归档规则设置
- (void)encodeWithCoder:(NSCoder *)encoder {
    unsigned int count;
    Ivar *ivar = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar iv = ivar[i];
        const char *name = ivar_getName(iv);
        NSString *strName = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:strName];
        [encoder encodeObject:value forKey:strName];
    }
    free(ivar);
}

@end
