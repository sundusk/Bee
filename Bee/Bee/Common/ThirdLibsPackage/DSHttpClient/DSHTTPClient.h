//
//  DSHTTPClient.h
//  DS08
//
//  Created by Ricky on 15/8/3.
//  Copyright (c) 2015年 Ricky. All rights reserved.
//

#import "AFHTTPSessionManager.h"


typedef void (^successBlock)(id data);
typedef void (^failedBlock)(NSError *error);
typedef void (^errorBlock)(NSString *message);

@interface DSHTTPClient : AFHTTPSessionManager

+ (DSHTTPClient *)shareInstance;

// GET请求方法
+ (void)getUrlString:(NSString *)url
           withParam:(NSDictionary *)param
    withSuccessBlock:(successBlock)success
     withFailedBlock:(failedBlock)failed
      withErrorBlock:(errorBlock)error;

// POST请求方法
+ (void)postUrlString:(NSString *)url
           withParam:(NSDictionary *)param
    withSuccessBlock:(successBlock)success
     withFailedBlock:(failedBlock)failed
      withErrorBlock:(errorBlock)error;


@end


