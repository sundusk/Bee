//
//  DQ_AddAdressCell.m
//  Bee
//
//  Created by Apple on 16/9/10.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "DQ_AddAdressCell.h"

@interface DQ_AddAdressCell()
//cell字段全局化
@property(weak,nonatomic)UILabel *name;
@property(weak,nonatomic)UILabel *num;
@property(weak,nonatomic)UILabel *address;
@end

@implementation DQ_AddAdressCell

#pragma mark -填充子控件
-(void)setModel:(DQ_AddressModel *)model{
    _model = model;
    _name.text = model.name;
    _num.text = model.phoneNum;
    _address.text = [NSString stringWithFormat:@"%@%@",_model.address,_model.houseNum];
}

#pragma mark -搭建界面
-(void)setupUI{
    //左侧黄条
    UIView *yellowV = [[UIView alloc]init];
    yellowV.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:yellowV];
    //名字
    UILabel *nameLabel = [UILabel bee_labelWithText:nil andColor:[UIColor blackColor] andFontSize:12];
    [self.contentView addSubview:nameLabel];
    _name = nameLabel;
    //电话
    UILabel *numLabel = [UILabel bee_labelWithText:nil andColor:[UIColor blackColor] andFontSize:12];
    [self.contentView addSubview:numLabel];
    _num = numLabel;
    //地址
    UILabel *addressLabel = [UILabel bee_labelWithText:nil andColor:[UIColor grayColor] andFontSize:12];
    [self.contentView addSubview:addressLabel];
    _address = addressLabel;
    //右侧分界线
    UIView *seperateV = [[UIView alloc]init];
    seperateV.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:seperateV];
    //右侧按钮
    UIButton *editBtn = [[UIButton alloc]init];
    [editBtn setImage:[UIImage imageNamed:@"v2_address_edit_normal"] forState:UIControlStateNormal];
    [editBtn setImage:[UIImage imageNamed:@"v2_address_edit_highlighted"] forState:UIControlStateSelected];
    [editBtn sizeToFit];
    [self.contentView addSubview:editBtn];
    //点击按钮跳转到编辑控制器
    [editBtn addTarget:self action:@selector(gotoEdit) forControlEvents:UIControlEventTouchUpInside];
    //设置约束
    [yellowV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(2);
        make.size.mas_equalTo(CGSizeMake(5, 60));
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yellowV.mas_right).offset(15);
        make.top.equalTo(self.contentView).offset(8);
    }];
    
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_right).offset(30);
        make.top.equalTo(nameLabel);
    }];
    
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel);
        make.top.equalTo(nameLabel.mas_bottom).offset(15);
    }];
    
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [seperateV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.right.equalTo(editBtn.mas_left).offset(-20);
        make.size.mas_equalTo(CGSizeMake(1, 45));
    }];
    
    //给tableviewcell设置向上的约束
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(yellowV.mas_bottom).offset(2);
    }];
}

#pragma mark -按钮的点击事件
-(void)gotoEdit{
    //通知事件,将cell数据传递过去
    [[NSNotificationCenter defaultCenter] postNotificationName:@"gotoEdit" object:self];
}
@end
