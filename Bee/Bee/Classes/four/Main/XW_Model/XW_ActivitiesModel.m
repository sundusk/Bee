//
//  XW_ActivitiesModel.m
//  Bee
//
//  Created by 9264 on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "XW_ActivitiesModel.h"

@implementation XW_ActivitiesModel
+ (instancetype)newsWithDict:(NSDictionary *)dict
{
    XW_ActivitiesModel *model = [[XW_ActivitiesModel alloc] init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{};
@end

