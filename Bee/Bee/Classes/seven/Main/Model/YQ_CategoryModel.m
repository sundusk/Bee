//
//  YQ_CategoryModel.m
//  Bee
//
//  Created by 黄跃奇 on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "YQ_CategoryModel.h"
#import "DSHTTPClient.h"

@implementation YQ_CategoryModel

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    
    
    
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"%@ -- %@", self.name, self.id];
    
}


@end
