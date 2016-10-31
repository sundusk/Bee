//
//  DQ_MarkIconCell.m
//  Bee
//
//  Created by Apple on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "DQ_MarkIconCell.h"

@implementation DQ_MarkIconCell

#pragma mark -搭建界面
-(void)setupUI{
    //1.左侧黄色视图
    UIView *yellowV = [[UIView alloc]init];
    yellowV.backgroundColor = [UIColor yellowColor];
    yellowV.layer.cornerRadius = 2;
    [self.contentView addSubview:yellowV];
    //2.label
    UILabel *label = [UILabel bee_labelWithText:@"闪送超市" andColor:[UIColor grayColor] andFontSize:12];
    [self.contentView addSubview:label];
    //3.布局
    [yellowV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(8);
        make.size.mas_equalTo(CGSizeMake(5, 20));
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yellowV.mas_right).offset(10);
        make.centerY.equalTo(yellowV);
    }];
    
    //给tableviewcell设置向上的约束
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(yellowV.mas_bottom).offset(8);
    }];
}

@end
