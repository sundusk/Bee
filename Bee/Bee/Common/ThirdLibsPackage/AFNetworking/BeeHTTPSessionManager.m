//
//  BeeHTTPSessionManager.m
//  Bee
//
//  Created by yaoshuai on 16/9/7.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "BeeHTTPSessionManager.h"

@implementation BeeHTTPSessionManager

+ (instancetype)sharedManager
{
    static BeeHTTPSessionManager *manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [self manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    });
    return manager;
}

@end
