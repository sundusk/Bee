//
//  BeeFMDatabaseQueue.h
//  Bee
//
//  Created by yaoshuai on 16/9/7.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <FMDB/FMDB.h>

@interface BeeFMDatabaseQueue : FMDatabaseQueue

+ (instancetype)sharedQueue;

@end
