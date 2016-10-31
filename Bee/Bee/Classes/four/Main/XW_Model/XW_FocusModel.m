//
//  XW_FocusModel.m
//  Bee
//
//  Created by 9264 on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "XW_FocusModel.h"

@implementation XW_FocusModel
+ (instancetype)newsWithDict:(NSDictionary *)dict
{
    XW_FocusModel *model = [[XW_FocusModel alloc] init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{};
@end
