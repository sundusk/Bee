//
//  DQ_Control.m
//  Bee
//
//  Created by Apple on 16/9/11.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "DQ_Control.h"

@implementation DQ_Control

+(instancetype)Control{
    return [[self alloc]init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark -搭建界面
-(void)setupUI{
    //增加按钮
    UIButton *addBtn = [[UIButton alloc]init];
    
    [self addSubview:addBtn];
    //减少按钮
    //中间数量label
}

@end
