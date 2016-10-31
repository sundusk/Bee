//
//  CZView.m
//  手势解锁111
//
//  Created by HaoYoson on 15/7/16.
//  Copyright (c) 2015年 www.hao.today. All rights reserved.
//

#import "HMGestureUnlockView.h"
#import "SVProgressHUD.h"

@interface HMGestureUnlockView ()

@property (strong, nonatomic) NSMutableArray *btns;

@property (strong, nonatomic) NSMutableArray<UIButton *> *lineBtns;

@property (assign, nonatomic) CGPoint currentPoint;
@end

@implementation HMGestureUnlockView

// 懒加载 初始化 需要连线的的按钮的数组
- (NSMutableArray<UIButton *> *)lineBtns
{
    if (!_lineBtns) {
        _lineBtns = [NSMutableArray array];
    }
    return _lineBtns;
}

// 懒加载 初始化 数组
- (NSMutableArray *)btns
{
    if (!_btns) {
        _btns = [NSMutableArray array];
        for (int i = 0; i < 9; i++) {
            UIButton *btn = [[UIButton alloc] init];
            // 取消默认点击高亮状态
            [btn setUserInteractionEnabled:NO];
            // 设置按钮的图片
            [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
            [btn setImage:[UIImage imageNamed:@"gesture_node_error"] forState:UIControlStateDisabled];

            btn.tag = i;

            [_btns addObject:btn];
            [self addSubview:btn];
        }
        self.backgroundColor = [UIColor clearColor];
    }
    return _btns;
}

// 布局button
- (void)layoutSubviews
{
    // !!!
    [super layoutSubviews];

    // 计算九宫格位置
    CGFloat w = 74;
    CGFloat h = w;
    int colCount = 3;
    CGFloat margin = (self.frame.size.width - 3 * w) / 4;
    for (int i = 0; i < self.btns.count; i++) {
        CGFloat x = (i % colCount) * (margin + w) + margin;
        CGFloat y = (i / colCount) * (margin + w) + margin;
        [self.btns[i] setFrame:CGRectMake(x, y, w, h)];
    }
}

// 触摸到CZView调用
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    // 拿到触摸对象
    UITouch *touch = touches.anyObject;
    // 获取我点击的坐标
    CGPoint point = [touch locationInView:touch.view];
    // 判断这坐标是不是在按钮的区域范围内
    for (int i = 0; i < self.btns.count; i++) {
        // 如果在 那么让这个按钮变成 高亮状态
        if (CGRectContainsPoint([self.btns[i] frame], point)) {
            [self.btns[i] setSelected:YES];
            // 先判断 数组中是否已经存在这个按钮 如果已经存在那么不添加
            if (![self.lineBtns containsObject:self.btns[i]]) {
                // 把需要连线的按钮 添加到 数组中
                [self.lineBtns addObject:self.btns[i]];
            }
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{

    // 拿到触摸对象
    UITouch *touch = touches.anyObject;
    // 获取我点击的坐标
    CGPoint point = [touch locationInView:touch.view];

    // 获取当前手指的位置
    self.currentPoint = point;

    // 判断这坐标是不是在按钮的区域范围内
    for (int i = 0; i < self.btns.count; i++) {
        // 如果在 那么让这个按钮变成 高亮状态
        if (CGRectContainsPoint([self.btns[i] frame], point)) {
            [self.btns[i] setSelected:YES];
            // 先判断 数组中是否已经存在这个按钮 如果已经存在那么不添加
            if (![self.lineBtns containsObject:self.btns[i]]) {
                // 把需要连线的按钮 添加到 数组中
                [self.lineBtns addObject:self.btns[i]];
            }
        }
    }

    // 重绘
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    for (int i = 0; i < self.btns.count; i++) {
    //        [self.btns[i] setHighlighted:NO];
    //    }

    // 判断需要连线的按钮是否有东西 如果没有直接返回(不需要进行密码相关的操作)
    if (!self.lineBtns.count) {
        return;
    }

    self.currentPoint = [[self.lineBtns lastObject] center];
    // 重绘
    [self setNeedsDisplay];

    // 拼接密码
    NSString *pwd = @"";
    for (int i = 0; i < self.lineBtns.count; i++) {
        pwd = [pwd stringByAppendingString:[NSString stringWithFormat:@"%ld", [self.lineBtns[i] tag]]];
    }
    NSLog(@"%@", pwd);

    // 开启上下文
    UIGraphicsBeginImageContext(self.bounds.size);

    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    // 截图
    [self.layer renderInContext:ctx];

    // 通过上下文获取image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    // 关闭上下文
    UIGraphicsEndImageContext();

    // 把密码传递给控制器 再进行判断
    if (self.pwdBlock) {
        if (self.pwdBlock(pwd, image)) {
            // 正确
            // 恢复到原始状态
            [self clear];
        }
        else {
            // 错误
            // 如果密码错误 禁用整个控件
            [self setUserInteractionEnabled:NO];

            for (int i = 0; i < self.lineBtns.count; i++) {
                [self.lineBtns[i] setEnabled:NO];
                [self.lineBtns[i] setSelected:NO];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 恢复控件的使用
                [self setUserInteractionEnabled:YES];
                // 恢复到原始状态
                [self clear];
            });
        }
    }

    // 撒手的时候 取消按钮的高亮状态
    [self.btns makeObjectsPerformSelector:@selector(setHighlighted:) withObject:@(NO)];
}

// 恢复到原始状态
- (void)clear
{
    for (int i = 0; i < self.btns.count; i++) {
        UIButton *btn = self.btns[i];
        btn.selected = NO;
        btn.highlighted = NO;
        btn.enabled = YES;
    }
    // 清空
    [self.lineBtns removeAllObjects];
    // 重绘
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code

    UIBezierPath *path = [UIBezierPath bezierPath];

    // 设置连线的样式
    [path setLineWidth:10];
    [path setLineCapStyle:kCGLineCapRound];
    [path setLineJoinStyle:kCGLineJoinRound];

    [[UIColor whiteColor] set];

    for (int i = 0; i < self.lineBtns.count; i++) {
        if (i == 0) {
            // 如果是第一个点 应该 移动到这个点的位置上
            [path moveToPoint:[self.lineBtns[i] center]];
        }
        else {
            // 如果是其他的点 那么应该直接联系 addLine
            [path addLineToPoint:[self.lineBtns[i] center]];
        }
    }

    // 如果需要画线的按钮的数组没有值 就不要画连接到手指位置的线
    if (self.lineBtns.count) {
        [path addLineToPoint:self.currentPoint];
    }

    [path stroke];
}

//// 从xib加载的时候调用
//- (void)awakeFromNib
//{
//    NSLog(@"awakeFromNib");
//
//    for (int i = 0; i < 9; i++) {
//        UIButton* btn = [[UIButton alloc] init];
//        [self.btns addObject:btn];
//        [self addSubview:btn];
//    }
//}

@end
