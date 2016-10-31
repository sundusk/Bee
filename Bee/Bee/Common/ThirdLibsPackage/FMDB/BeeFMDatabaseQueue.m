//
//  BeeFMDatabaseQueue.m
//  Bee
//
//  Created by yaoshuai on 16/9/7.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "BeeFMDatabaseQueue.h"

@implementation BeeFMDatabaseQueue

+ (instancetype)sharedQueue
{
    static BeeFMDatabaseQueue *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 数据库的沙盒路径
        NSString *dbPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"bee.db"];
        instance = [BeeFMDatabaseQueue databaseQueueWithPath:dbPath];
        //创建地址表
        [instance inDatabase:^(FMDatabase *db) {
            // 创建存储收货地址的数据库表的SQL
            NSString *createSQL = @"create table if not exists t_beeAddress(id integer primary key not null,name text,isMale text,phoneNum text,city text,address text,houseNum text,cellID text);";
            // 执行创建数据库表的SQL
            [db executeUpdate:createSQL];
        }];
    });
    return instance;
}

@end
