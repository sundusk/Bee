//
//  YQ_ProductsOrderControl.m
//  Bee
//
//  Created by 黄跃奇 on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "YQ_ProductsOrderControl.h"

@interface YQ_ProductsOrderControl ()

/**
 *  减少按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *reduceButton;

/**
 *  显示产品订单数量的label
 */
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;


@end

@implementation YQ_ProductsOrderControl

#pragma mark - 加载视图
+ (instancetype)productsOrderControl {
    
    return [[NSBundle mainBundle] loadNibNamed:@"YQ_ProductsOrderControl" owner:nil options:nil].lastObject;
    
}

#pragma mark - 初始化设置
- (void)awakeFromNib {
    
    //初始化设置
    self.count = 0;
    
}



#pragma mark - 按钮的点击事件
/**
 *  减少按钮
 */
- (IBAction)reduceButtonClick:(UIButton *)sender {
    
    self.count--;
    
    //减少
    self.isIncrease = NO;
    
    //产品订单数量减少，发送事件
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    //减少产品
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reduceProducts" object:@(_count) userInfo:nil];
}

/**
 *  增加按钮
 */
- (IBAction)increaseButtonClick:(UIButton *)sender {
    
    self.count++;
    
    //增加
    self.isIncrease = YES;
    
    UIWindow *keyW = [UIApplication sharedApplication].keyWindow;
    _startP = [self convertPoint:sender.center toView:keyW];
    
    //产品订单数量增加，发送事件
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"increaseProducts" object:@(_count) userInfo:nil];
}

#pragma mark - 重写set方法，实现产品订单数量控制
- (void)setCount:(NSInteger)count {
    
    _count = count;
    
    //判断订单数量，控制控件是否隐藏
    if (count > 0) {
        
        //订单数量有值，可以实现减少功能
        _reduceButton.hidden = NO;
        _numberLabel.hidden = NO;
        
    } else {
        
        //订单数量为0，隐藏控件
        _reduceButton.hidden = YES;
        _numberLabel.hidden = YES;
        
    }
    
    //将产品订单数量信息显示到label上
    self.numberLabel.text = @(count).description;
}



@end
