//
//  BeeHTTPSessionManager.h
//  Bee
//
//  Created by yaoshuai on 16/9/7.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface BeeHTTPSessionManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

@end
