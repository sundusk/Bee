//
//  NSString+Path.h
//  工具包-OC
//
//  Created by yaoshuai on 16/8/30.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Path)

/**
 *  将文件的路径拼接到Documents里面
 *
 *  @return 拼接到Documents的路径
 */
- (NSString *)appendToDocumentsPath;

/**
 *  将文件的路径拼接到Cache里面
 *
 *  @return 拼接到Cache的路径
 */
- (NSString *)appendToCachePath;

/**
 *  将文件的路径拼接到tmp里面
 *
 *  @return 拼接到tmp的路径
 */
- (NSString *)appendToTmpPath;

@end