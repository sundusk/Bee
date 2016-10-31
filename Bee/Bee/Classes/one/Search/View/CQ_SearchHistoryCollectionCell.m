//
//  CQ_SearchHistoryCollectionCell.m
//  CCQ_Demo
//
//  Created by 神威 on 16/9/11.
//  Copyright © 2016年 ccq. All rights reserved.
//

#import "CQ_SearchHistoryCollectionCell.h"
CGFloat heightForCell = 35;
@implementation CQ_SearchHistoryCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self  = [super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = heightForCell / 2;
        self.backgroundColor = DefaultColor;
    }
    return self;
}

#pragma mark - titleLabel

- (UILabel *)titleLabel {
    if (!_titleLabel ) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, self.bounds.size.width, self.bounds.size.height)];
//        NSLog(@"%@",NSStringFromCGRect(_titleLabel.frame));
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 1;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}



@end
