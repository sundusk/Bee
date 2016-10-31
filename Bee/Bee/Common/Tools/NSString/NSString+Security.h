//
//  NSString+Security.h
//  工具包-OC
//
//  Created by yaoshuai on 16/8/27.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Security)

/**
 *  当前字符串(明文)转成base64编码之后的字符串
 *
 *  @return 当前字符串(明文)转成base64编码之后的字符串
 */
- (NSString *)base64EncodeString;

/**
 *  当前字符串(base64编码过的)转成base64解码之后的字符串
 *
 *  @return 当前字符串(base64编码过的)转成base64解码之后的字符串
 */
- (NSString *)base64DecodeString;

@end