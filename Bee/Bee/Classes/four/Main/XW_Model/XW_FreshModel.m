//
//  XW_FreshModel.m
//  Bee
//
//  Created by 9264 on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "XW_FreshModel.h"

@implementation XW_FreshModel
+ (instancetype)newsWithDict:(NSDictionary *)dict
{
    XW_FreshModel *model = [[XW_FreshModel alloc] init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{};
@end
