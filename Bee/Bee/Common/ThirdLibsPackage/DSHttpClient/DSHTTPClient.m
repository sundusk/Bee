//
//  DSHTTPClient.m
//  DS08
//
//  Created by Ricky on 15/8/3.
//  Copyright (c) 2015年 Ricky. All rights reserved.
//

#import "DSHTTPClient.h"


@implementation DSHTTPClient

+ (instancetype)shareInstance{
    
    static DSHTTPClient *client = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURL *url = [NSURL URLWithString:@"http://iosapi.itcast.cn/loveBeen/"];
        
        client = [[DSHTTPClient alloc]initWithBaseURL:url];
        client.requestSerializer = [[AFJSONRequestSerializer alloc]init];
    
        client.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    });
    
    return client;
    
}

+ (void)getUrlString:(NSString *)url
           withParam:(NSDictionary *)param
    withSuccessBlock:(successBlock)success
     withFailedBlock:(failedBlock)failed
      withErrorBlock:(errorBlock)error{
    
    [[self shareInstance] GET:url parameters:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary  *responseObject) {
        
        
       success(responseObject);
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failed(error);
        
    }];
    

}

+ (void)postUrlString:(NSString *)url
            withParam:(NSDictionary *)param
     withSuccessBlock:(successBlock)success
      withFailedBlock:(failedBlock)failed
       withErrorBlock:(errorBlock)error{
    
    [[self shareInstance] POST:url parameters:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary  *responseObject) {
        
        success(responseObject);

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failed(error);
        
    }];

}


@end
