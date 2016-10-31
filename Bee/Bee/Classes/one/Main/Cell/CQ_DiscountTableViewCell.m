//
//  CQ_DiscountTableViewCell.m
//  Bee
//
//  Created by 神威 on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "CQ_DiscountTableViewCell.h"

@implementation CQ_DiscountTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor whiteColor];
    NSLog(@"XXX");
    
    [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
}
- (IBAction)discount:(UIButton *)sender {
    NSLog(@"点击进入");
}

@end
