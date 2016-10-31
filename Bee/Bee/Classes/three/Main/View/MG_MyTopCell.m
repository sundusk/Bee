//
//  MG_MyTopCell.m
//  Bee
//
//  Created by yaoshuai on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "MG_MyTopCell.h"

@interface MG_MyTopCell()
{
    NSArray<UIButton *> *_btnArray;
    NSArray<NSString *> *_toVCNameArray;
}
@end

@implementation MG_MyTopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setupUI];
    }
    return self;
}

#pragma mark - 布局界面
- (void)setupUI
{
    _toVCNameArray = @[@"LW_OrderTableVC",@"YS_QuanVC",@"YQ_MsgVC"];
    
    self.contentView.backgroundColor = [UIColor bee_colorWithHex:0xf8f8f8 andAlpha:1];
    
    UIView *selectBgView = [[UIView alloc] initWithFrame:self.bounds];
    selectBgView.backgroundColor = [UIColor bee_colorWithHex:0xffffff andAlpha:1];
    self.selectedBackgroundView = selectBgView;
    
    NSMutableArray<UIButton *> *btnArray = [NSMutableArray array];
    [self createButtonWithTitle:@"我的订单" andImgName:@"v2_my_order_icon" andBtnArray:btnArray andTag:1];
    [self createButtonWithTitle:@"优惠券" andImgName:@"v2_my_coupon_icon" andBtnArray:btnArray andTag:2];
    [self createButtonWithTitle:@"我的消息" andImgName:@"v2_my_message_icon" andBtnArray:btnArray andTag:3];
    _btnArray = btnArray;
}
- (void)createButtonWithTitle:(NSString *)title andImgName:(NSString *)imgName andBtnArray:(NSMutableArray *)btnArr andTag:(NSInteger)tag
{
    UIButton *btn = [[UIButton alloc] init];
    btn.tag = tag;
    
    NSAttributedString *attStr = [NSAttributedString bee_imageTextWithImage:[UIImage imageNamed:imgName] imageWH:28.0f title:title fontSize:16.0f titleColor:[UIColor darkGrayColor] spacing:5.0f];
    [btn setAttributedTitle:attStr forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(clickJumpButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn sizeToFit];
    btn.titleLabel.numberOfLines = 0;
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:btn];
    [btnArr addObject:btn];
}
- (void)clickJumpButton:(UIButton *)sender
{
    NSString *toVC = _toVCNameArray[sender.tag - 1];
    if([self.delegate respondsToSelector:@selector(topCellJumpToVC:)])
    {
        [self.delegate topCellJumpToVC:toVC];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_btnArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:20 tailSpacing:20];
    [_btnArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
}

@end
