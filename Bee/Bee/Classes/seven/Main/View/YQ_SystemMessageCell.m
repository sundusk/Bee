//
//  YQ_SystemMessageCell.m
//  Bee
//
//  Created by 黄跃奇 on 16/9/9.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "YQ_SystemMessageCell.h"
#import "YQ_SystemMessageModel.h"

@interface YQ_SystemMessageCell ()

/**
 *  系统信息title
 */
@property(weak, nonatomic) UILabel *titleLabel;

/**
 *  信息内容content
 */
@property(weak, nonatomic) UILabel *contentLabel;

@end

@implementation YQ_SystemMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 设置UI界面
- (void)setupUI {
    
    //1. 系统信息title
    UILabel *titleLabel = [UILabel bee_labelWithText:@"消息" andColor:[UIColor blackColor] andFontSize:15];
    [self.contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.left.equalTo(self.contentView).offset(10);
    }];
    
    //2. 分隔线
    UIView *separateView = [[UIView alloc] init];
    separateView.backgroundColor = [UIColor bee_colorWithHex:0xeeeeee andAlpha:1.0];
    [self.contentView addSubview:separateView];
    
    [separateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel);
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(1);
    }];
    
    //3. 信息内容content
    UILabel *contentLabel = [UILabel bee_labelWithText:@"消息" andColor:[UIColor lightGrayColor] andFontSize:12];
    contentLabel.numberOfLines = 2;
    [self.contentView addSubview:contentLabel];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separateView.mas_bottom).offset(10);
        make.left.equalTo(titleLabel);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
    
    //4. 记录成员变量
    self.titleLabel = titleLabel;
    self.contentLabel = contentLabel;
    
}

- (void)setMessageModel:(YQ_SystemMessageModel *)messageModel {
    
    _messageModel = messageModel;
    
    self.titleLabel.text = messageModel.title;
    self.contentLabel.text = messageModel.content;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
