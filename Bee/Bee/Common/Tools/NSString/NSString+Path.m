//
//  NSString+Path.m
//  工具包-OC
//
//  Created by yaoshuai on 16/8/30.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "NSString+Path.h"

@implementation NSString (Path)

- (NSString *)appendToDocumentsPath
{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 获取文件的名字
    NSString *fileName = [self lastPathComponent];
    
    // Documents文件目录拼接文件的名字 == 文件保存到沙盒的路径
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
    
    return filePath;
}

- (NSString *)appendToCachePath
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    // 获取文件的名字
    NSString *fileName = [self lastPathComponent];
    // Cache文件目录拼接文件的名字 == 文件保存到沙盒的路径
    NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
    
    return filePath;
}

- (NSString *)appendToTmpPath
{
    NSString *tmpPath = NSTemporaryDirectory();
    
    // 获取文件的名字
    NSString *fileName = [self lastPathComponent];
    
    // tmp文件目录拼接文件的名字 == 文件保存到沙盒的路径
    NSString *filePath = [tmpPath stringByAppendingPathComponent:fileName];
    
    return filePath;
}

@end