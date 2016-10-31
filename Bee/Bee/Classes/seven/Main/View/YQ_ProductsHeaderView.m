//
//  YQ_ProductsHeaderView.m
//  Bee
//
//  Created by 黄跃奇 on 16/9/10.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "YQ_ProductsHeaderView.h"

@interface YQ_ProductsHeaderView ()

@property(weak, nonatomic) UILabel *titleLabel;

@end

@implementation YQ_ProductsHeaderView

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier  {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
        
    }
    
    return self;
    
}

#pragma mark - 设置UI界面
- (void)setupUI {
    
    // 添加label展示文字
    UILabel *titleLabel = [UILabel bee_labelWithText:@"优选水果" andColor:[UIColor darkGrayColor] andFontSize:13];
    
    [self.contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView);
        
    }];
    
    // 记录
    self.titleLabel = titleLabel;
    
}

- (void)setHeaderTitle:(NSString *)headerTitle {
    
    _headerTitle = headerTitle;
    
    self.titleLabel.text = headerTitle;
    
}

@end







