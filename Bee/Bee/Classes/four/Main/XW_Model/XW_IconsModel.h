//
//  XW_IconsModel.h
//  Bee
//
//  Created by 9264 on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XW_IconsModel : NSObject
@property(nonatomic,copy) NSString *img;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *customURL;
+ (instancetype)newsWithDict:(NSDictionary *)dict;
@end
