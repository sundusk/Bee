//
//  XW_ClassificationView.m
//  Bee
//
//  Created by 9264 on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "XW_ClassificationView.h"

@implementation XW_ClassificationView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    
    [self addButtons:@"Luck-draw" title:@"抽奖" tag:kButtonScan];
    [self addButtons:@"SecKill" title:@"秒杀" tag:kButtonCard];
    [self addButtons:@"Red-0" title:@"抢红包" tag:kButtonPay];
    [self addButtons:@"huddle-0" title:@"峰报团" tag:kButtonXiu];
    
    
}
-(void)addButtons:(NSString *)imageName title:(NSString *)title tag:(ClassificationButton)tag{
    UIButton *button = [[UIButton alloc]init];
    NSAttributedString *str = [NSAttributedString bee_imageTextWithImage:[UIImage imageNamed:imageName] imageWH:28 title:title fontSize:12 titleColor:[UIColor blackColor] spacing:5];
    [button setAttributedTitle:str forState:UIControlStateNormal];
    
    button.titleLabel.numberOfLines = 0;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button sizeToFit];
    
    [self addSubview:button];
    button.tag = tag;
    [button addTarget:self action:@selector(bottomTag:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)bottomTag:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(jumpToVC:)]) {
        [self.delegate jumpToVC:sender];
    }
}


- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat margin = (self.frame.size.width -10- self.subviews[0].frame.size.width * 4)/5;
    
    for (NSInteger i = 0; i<self.subviews.count - 1; i++) {
        
        UIButton *button = self.subviews[i];
        
        UIButton *nextButton = self.subviews[i+1];
        
        if (i == 0) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(self).offset(margin);
            }];
        }
        
        [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(button.mas_right).offset(margin);
            make.centerY.equalTo(self);
        }];
    }
}

@end
