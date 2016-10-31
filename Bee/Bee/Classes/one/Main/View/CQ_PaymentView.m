//
//  CQ_PaymentView.m
//  Bee
//
//  Created by 神威 on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "CQ_PaymentView.h"

#import "SVProgressHUD.h"

@implementation CQ_PaymentView

- (instancetype)init{
    
    if(self = [super init]){
        [self setupUI];
        
    }
    return self;
}


- (void)setupUI{
    
    
    self.backgroundColor = [UIColor grayColor];
    
}

#pragma mark - 确认付款点击事件
- (IBAction)paymentButton:(UIButton *)sender {
    
    [SVProgressHUD showErrorWithStatus:@"支付错误"];
}


@end
