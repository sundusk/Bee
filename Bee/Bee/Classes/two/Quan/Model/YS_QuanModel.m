//
//  YS_QuanModel.m
//  Bee
//
//  Created by yaoshuai on 16/9/9.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "YS_QuanModel.h"

@implementation YS_QuanModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if([key isEqualToString:@"description"])
    {
        [super setValue:value forKey:@"desc"];
    }
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

@end