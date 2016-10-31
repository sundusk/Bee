//
//  CQ_PayTableViewCell.m
//  Bee
//
//  Created by 神威 on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "CQ_PayTableViewCell.h"

@implementation CQ_PayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor greenColor];
    
    
   
}
- (IBAction)pay:(UIButton *)sender {
    
    NSLog(@"支付成功");
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
