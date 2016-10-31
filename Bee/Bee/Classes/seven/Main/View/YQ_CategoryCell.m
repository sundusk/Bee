//
//  YQ_CategoryCell.m
//  Bee
//
//  Created by 黄跃奇 on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "YQ_CategoryCell.h"

@implementation YQ_CategoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
        
    }
    
    return self;
    
}

#pragma mark - 设置UI界面
- (void)setupUI {
    
    //1、设置默认的背景颜色
    self.contentView.backgroundColor = [UIColor bee_colorWithHex:0xf8f8f8 andAlpha:1.0];
    
    //2、设置标题的颜色、大小、对齐方式
    self.textLabel.font = [UIFont systemFontOfSize:14];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    
    //3、设置选中的背景
    UIView *selectBg = [[UIView alloc] init];
    selectBg.backgroundColor = [UIColor bee_colorWithHex:0xffffff andAlpha:1.0];
    self.selectedBackgroundView = selectBg;
    
    //4、黄色的竖线
    UIView *vLine = [[UIView alloc] init];
    vLine.backgroundColor = [UIColor bee_colorWithHex:0xffd900 andAlpha:1.0];
    [selectBg addSubview:vLine];
    
    [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(4);
        make.height.equalTo(selectBg);
        make.left.centerY.equalTo(selectBg);
        
    }];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
