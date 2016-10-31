//
//  DQ_GoodsView.m
//  Bee
//
//  Created by Apple on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "DQ_GoodsView.h"

@implementation DQ_GoodsView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark -搭建界面
-(void)setupUI{
    
}

//主控制器移除之后调用此方法
-(void)removeFromSuperview{
    //除去自己的子视图
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

@end
