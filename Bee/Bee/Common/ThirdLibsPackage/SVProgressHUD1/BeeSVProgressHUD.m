//
//  BeeSVProgressHUD.m
//  Bee
//
//  Created by yaoshuai on 16/9/7.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "BeeSVProgressHUD.h"

@implementation BeeSVProgressHUD

+ (instancetype)sharedHUD
{
    static BeeSVProgressHUD *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

@end
