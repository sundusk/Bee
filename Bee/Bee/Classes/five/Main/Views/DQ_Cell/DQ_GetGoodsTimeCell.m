//
//  DQ_GetGoodsTimeCell.m
//  Bee
//
//  Created by Apple on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "DQ_GetGoodsTimeCell.h"
@interface DQ_GetGoodsTimeCell()
@property(weak,nonatomic)UILabel *cautionLabel;
@property(weak,nonatomic)UILabel *reserveLabel;
@end
@implementation DQ_GetGoodsTimeCell

-(void)setTime:(NSString *)time{
    _time = time;
    _cautionLabel.text = [NSString stringWithFormat:@"预计%@内送达",time];
    [_reserveLabel removeFromSuperview];
}

#pragma mark -搭建界面
-(void)setupUI{
    //右侧箭头
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //收货时间
    UILabel *getGoodsLabel = [UILabel bee_labelWithText:@"收货时间" andColor:[UIColor blackColor] andFontSize:10];
    [self.contentView addSubview:getGoodsLabel];
    //闪电送
    UILabel *cautionLabel = [UILabel bee_labelWithText:@"一小时送达" andColor:[UIColor redColor] andFontSize:10];
    [self.contentView addSubview:cautionLabel];
    _cautionLabel = cautionLabel;
    //可预订
    UILabel *reserveLabel = [UILabel bee_labelWithText:@"可预订" andColor:[UIColor blackColor] andFontSize:10];
    [self.contentView addSubview:reserveLabel];
    _reserveLabel = reserveLabel;
    //起送,满减,优惠信息
    UILabel *preferentialLabel = [UILabel bee_labelWithText:@"¥ 0起送,22:00前满¥ 30减免运费,22:00后满¥ 69免运费" andColor:[UIColor grayColor] andFontSize:10];
    [self.contentView addSubview:preferentialLabel];
    //布局子控件
    [getGoodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(8);
        make.left.equalTo(self.contentView).offset(15);
    }];
    
    [preferentialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(getGoodsLabel);
        make.top.equalTo(getGoodsLabel.mas_bottom).offset(8);
        make.bottom.equalTo(self.contentView).offset(-8);
    }];
    
    [reserveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-40);
        make.top.equalTo(getGoodsLabel);
    }];
    
    [cautionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(preferentialLabel).offset(20);
        make.top.equalTo(getGoodsLabel);
    }];
    //给tableviewcell设置向上的约束
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(preferentialLabel.mas_bottom).offset(8);
    }];
  
}

@end
