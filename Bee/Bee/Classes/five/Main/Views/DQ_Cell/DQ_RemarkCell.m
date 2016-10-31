//
//  DQ_RemarkCell.m
//  Bee
//
//  Created by Apple on 16/9/9.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "DQ_RemarkCell.h"
@interface DQ_RemarkCell()
@property(weak,nonatomic)UILabel *remarkLabel;
@end

@implementation DQ_RemarkCell


#pragma mark -搭建界面
-(void)setupUI{
    
    //右侧箭头图标
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //备注Label
    UILabel *remarkLabel = [UILabel bee_labelWithText:@"备注" andColor:[UIColor blackColor] andFontSize:12];
    [self.contentView addSubview:remarkLabel];
    //要求label
    _detailLabel = [[UILabel alloc]init];
    _detailLabel.textColor = [UIColor lightGrayColor];
    //设置右对齐,不换行
    _detailLabel.textAlignment = NSTextAlignmentRight;
    _detailLabel.numberOfLines = 1;
    _detailLabel.font = [UIFont systemFontOfSize:13];
    _detailLabel.alpha = 0.6;
    _detailLabel.text = @"其他要求(如带一瓶82年的雪碧)";
    [_detailLabel sizeToFit];
    [self.contentView addSubview:_detailLabel];
 
    
    //设置约束
    [remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(15);
    }];
    
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(remarkLabel);
        make.right.equalTo(self.contentView).offset(-40);
        make.width.mas_equalTo(200);
    }];
    //给tableviewcell设置向上的约束
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(remarkLabel.mas_bottom).offset(15);
    }];
}

@end
