//
//  NSString+YS.m
//  工具包-OC
//
//  Created by yaoshuai on 16/8/14.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "NSString+Bee.h"

@implementation NSString (Bee)

- (BOOL)isEmpty
{
    if (!self) {
        return true;
    }
    else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [self stringByTrimmingCharactersInSet:set];
        
        return trimedString.length == 0;
    }
}

@end
