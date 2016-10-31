//
//  DQ_SelectedGoods.m
//  Bee
//
//  Created by Apple on 16/9/12.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "DQ_SelectedGoods.h"

@implementation DQ_SelectedGoods

+(instancetype)sharedSelectedGoods{
    static DQ_SelectedGoods *modelList;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        modelList = [[self alloc]init];
    });
    return modelList;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _selectedGoodsArry = [NSMutableArray array];
    }
    return self;
}
@end
