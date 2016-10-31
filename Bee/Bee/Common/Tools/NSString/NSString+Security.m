//
//  NSString+Security.m
//  工具包-OC
//
//  Created by yaoshuai on 16/8/27.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "NSString+Security.h"

@implementation NSString (Security)

- (NSString *)base64EncodeString
{
    if(![self isEmpty])
    {
        // 将“源字符串”转成二进制(因base64的编解码都是针对二进制的)
        NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
        
        // 返回二进制编码后的字符串
        return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    else
    {
        return @"";
    }
}

- (NSString *)base64DecodeString
{
    if(![self isEmpty])
    {
        // 编码后的字符串转成二进制
        NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
        
        // 返回二进制解码后的字符串
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    else
    {
        return @"";
    }
}

@end
