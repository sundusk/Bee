//
//  XW_IconsModel.m
//  Bee
//
//  Created by 9264 on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "XW_IconsModel.h"

@implementation XW_IconsModel
+ (instancetype)newsWithDict:(NSDictionary *)dict
{
    XW_IconsModel *model = [[XW_IconsModel alloc] init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{};
@end
