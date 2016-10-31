//
//  DQ_GoodsCell.m
//  Bee
//
//  Created by Apple on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "DQ_GoodsCell.h"
#import "DQ_AddressModel.h"

@interface DQ_GoodsCell()

//子控件全局化
@property(weak,nonatomic)UILabel *nameLabel;
@property(weak,nonatomic)UILabel *nameValue;
@property(weak,nonatomic)UILabel *sexLabel;
@property(weak,nonatomic)UILabel *phoneLabel;
@property(weak,nonatomic)UILabel *phoneNum;
@property(weak,nonatomic)UILabel *addressLabel;
@property(weak,nonatomic)UILabel *addressValue;
@property(weak,nonatomic)UILabel *updateLabel;
@end

@implementation DQ_GoodsCell

#pragma mark -填充子控件
-(void)setAddressModel:(DQ_AddressModel *)addressModel{
    _addressModel = addressModel;
    if (addressModel == nil) {
        [self setupUI];
    }else{
        [self ShowAddress];
    }
}

#pragma mark -搭建界面
-(void)setupUI{
    //没有地址时显示
    self.textLabel.text = @"鲜蜂侠需要您的坐标";
    [self.textLabel setTextColor:[UIColor redColor]];
    [self.textLabel setFont:[UIFont systemFontOfSize:14]];
    [_nameValue removeFromSuperview];
    [_nameLabel removeFromSuperview];
    [_sexLabel removeFromSuperview];
    [_phoneLabel removeFromSuperview];
    [_phoneNum removeFromSuperview];
    [_addressLabel removeFromSuperview];
    [_addressValue removeFromSuperview];
    [_updateLabel removeFromSuperview];
    
}

#pragma mark -展示地址
-(void)ShowAddress{
    //地址不为空时重新布局子控件
    //头尾广告条
    UIImageView *topImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"信封条"]];
    topImageV.contentMode = UIViewContentModeScaleAspectFill;
    [topImageV sizeToFit];
    [self.contentView addSubview:topImageV];
    
    UIImageView *bottomImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"信封条"]];
    bottomImageV.contentMode = UIViewContentModeScaleAspectFill;
    [bottomImageV sizeToFit];
    [self.contentView addSubview:bottomImageV];
    //收货人
    UILabel *nameLabel = [UILabel bee_labelWithText:@"收 货 人" andColor:[UIColor blackColor] andFontSize:12];
    [self.contentView addSubview:nameLabel];
    _nameLabel = nameLabel;
    //姓名
    UILabel *nameValue = [UILabel bee_labelWithText:_addressModel.name andColor:[UIColor blackColor] andFontSize:12];
    [self.contentView addSubview:nameValue];
    _nameValue = nameValue;
    //性别
    NSString *sex;
    if ([_addressModel.isMale isEqualToString:@"1"]) {
        sex = @"先生";
    }else{
        sex = @"女士";
    }
    UILabel *sexLabel = [UILabel bee_labelWithText:sex andColor:[UIColor blackColor] andFontSize:12];
    [self.contentView addSubview:sexLabel];
    _sexLabel = sexLabel;
    //电话
    UILabel *phoneLabel = [UILabel bee_labelWithText:@"电  话" andColor:[UIColor blackColor] andFontSize:12];
    [self.contentView addSubview:phoneLabel];
    _phoneLabel = phoneLabel;
    //号码
    UILabel *phoneNum = [UILabel bee_labelWithText:_addressModel.phoneNum andColor:[UIColor blackColor] andFontSize:12];
    [self.contentView addSubview:phoneNum];
    _phoneNum = phoneNum;
    //地址
    UILabel *addressLabel = [UILabel bee_labelWithText:@"收货地址" andColor:[UIColor blackColor] andFontSize:12];
    [self.contentView addSubview:addressLabel];
    _addressLabel = addressLabel;
    //地址值
    NSString *address = [NSString stringWithFormat:@"%@%@",_addressModel.address,_addressModel.houseNum];
    UILabel *addressValue = [UILabel bee_labelWithText:address andColor:[UIColor blackColor] andFontSize:12];
    [self.contentView addSubview:addressValue];
    _addressValue = addressValue;
    //修改提示
    UILabel *updateLabel = [UILabel bee_labelWithText:@"修改" andColor:[UIColor blackColor] andFontSize:14];
    [self.contentView addSubview:updateLabel];
    _updateLabel = updateLabel;
    //设置约束
    [topImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.height.mas_equalTo(2);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImageV).offset(5);
        make.left.equalTo(self.contentView).offset(8);
    }];
    
    [nameValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_right).offset(10);
        make.top.equalTo(nameLabel);
    }];
    
    [sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameValue);
        make.left.equalTo(nameValue.mas_right).offset(10);
    }];
    
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel);
        make.top.equalTo(nameLabel.mas_bottom).offset(8);
    }];
    
    [phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneLabel);
        make.left.equalTo(nameValue);
    }];
    
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneLabel);
        make.top.equalTo(phoneLabel.mas_bottom).offset(8);
    }];
    
    [addressValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressLabel);
        make.left.equalTo(phoneNum);
    }];
    
    [updateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-40);
        make.centerY.equalTo(self.contentView);
    }];
    
    [bottomImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(2);
    }];
    //给tableviewcell设置向上的约束
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(addressLabel.mas_bottom).offset(5);
    }];
    self.textLabel.text = nil;
    
}

#pragma mark - 移除通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
