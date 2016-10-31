//
//  YS_OrderModel.h
//  Bee
//
//  Created by yaoshuai on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YS_OrderModel : NSObject

@property (copy, nonatomic) NSString *time;
@property (copy, nonatomic) NSString *state;
@property (copy, nonatomic) NSString *count;
@property (copy, nonatomic) NSString *money;
@property (strong, nonatomic) NSArray <UIImage *> *imgArray;

@end
