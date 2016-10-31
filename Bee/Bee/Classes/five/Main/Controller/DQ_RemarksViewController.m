//
//  DQ_RemarksViewController.m
//  Bee
//
//  Created by Apple on 16/9/9.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "DQ_RemarksViewController.h"

@interface DQ_RemarksViewController ()<UITextViewDelegate>

@end

@implementation DQ_RemarksViewController{
    //第一行按钮
    NSMutableArray *_arry_one;
    //第二行按钮
    NSMutableArray *_arry_two;
    //全局Button用于计算
    UIButton *_currentBtn;
    //全局Label设置隐藏属性
    UILabel *_cautionLabel;
    UILabel *_rightLabel;
    //textView全局化
    UITextView *_textView;
    //字符串数组
    NSMutableArray <NSString *>*_stringArr;
    //保存所有的按钮下标用于判断按钮选中状态
    NSMutableArray <NSNumber *>*_btnArry;
    //备用文本数组
    NSArray <NSString *>*_remarksArry;
    //保存所有按钮
    NSMutableArray <UIButton *>*_buttonList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"订单备注";
    self.view.backgroundColor = [UIColor bee_colorWithRed:217 andGreen:217 andBlue:217 andAlpha:1.0];
    //实例化数组
    _arry_one = [NSMutableArray array];
    _arry_two = [NSMutableArray array];
    _stringArr = [NSMutableArray array];
    _btnArry = [NSMutableArray array];
    _buttonList = [NSMutableArray array];
    [self setupUI];
}

#pragma mark - 根据传入的文件名称,拼接全路径并返回!
- (NSString *)filePathWithFileName:(NSString *)fileName {
    // 1.获取docPath
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    // 2.拼接
    NSString *filePath = [docPath stringByAppendingPathComponent:fileName];
    // 3.返回
    return filePath;    
}

#pragma mark -点击事件
-(void)addRemarkInfo:(UIButton *)sender{
    //保存已经选中的按钮
    [_btnArry addObject:@(sender.tag)];
    //保存至缓存
    NSString *filePath = [self filePathWithFileName:@"remarks.plist"];
    [_btnArry writeToFile:filePath atomically:YES];
    
    //隐藏提示文字
    _cautionLabel.hidden = YES;
    _rightLabel.hidden = YES;
    //获取按钮中的文字
    NSString *btnContainer = sender.titleLabel.text;
    //保存至字符串数组中
    [_stringArr addObject:btnContainer];
    //将字符串数组的文字显示到textView
    _textView.text = [_stringArr componentsJoinedByString:@" "];
    //关闭按钮
    sender.enabled = NO;
}

-(void)finishChoose{
    //1.先获取textView中的字符
    NSString *writeStr = _textView.text;
    //通知传值
    [[NSNotificationCenter defaultCenter] postNotificationName:@"finishChoose" object:writeStr];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -搭建界面
-(void)setupUI{
    //上部分view
    UIView *topV = [[UIView alloc]init];
    topV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topV];
    //tag
    __block NSInteger i = 0;
    //上部分view中添加6个备注按钮控件,设置边框
    NSArray *arry = @[@"注意保质期 ",@"送货前打电话 ",@"尽快送货 ",@"到了打电话 ",@"中午前送到 ",@"水果要新鲜 "];
    _remarksArry = arry;
    [arry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *remarksDemoBtn =  [UIButton bee_buttonWithTitle:obj andFontSize:12 andNormalColor:[UIColor grayColor] andSelectedColor:[UIColor blackColor]];
        //给按钮设置边框
        remarksDemoBtn.layer.cornerRadius = 5;
        remarksDemoBtn.layer.borderWidth = 1;
        remarksDemoBtn.layer.borderColor = [UIColor grayColor].CGColor;
        [topV addSubview:remarksDemoBtn];
        //设置按钮的tag
        i++;
        remarksDemoBtn.tag = i;
        //读取缓存
        NSString *filePath = [self filePathWithFileName:@"remarks.plist"];
        NSArray <NSNumber *>*stateButton = [NSArray arrayWithContentsOfFile:filePath];
        [stateButton enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.intValue == i) {
                //屏蔽按钮点击
                remarksDemoBtn.enabled = NO;
                //将按钮的内容赋值给tableView
                [_stringArr addObject:remarksDemoBtn.titleLabel.text];
            }
        }];
        
        //设置选中背景
        [remarksDemoBtn setBackgroundImage:[UIImage imageNamed:@"v2_coupon_verify_selected"] forState:UIControlStateNormal];
        [remarksDemoBtn setBackgroundImage:[UIImage imageNamed:@"v2_coupon_verify_normal"] forState:UIControlStateSelected];
        //点击事件
        [remarksDemoBtn addTarget:self action:@selector(addRemarkInfo:) forControlEvents:UIControlEventTouchUpInside];
        //保存第一个按钮用于计算
        if (idx == 0) {
            _currentBtn = remarksDemoBtn;
        }
        //前三个保存数组
        if ( idx < 3) {
            [_arry_one addObject:remarksDemoBtn];
        }else{
            //后三个保存数组
            [_arry_two addObject:remarksDemoBtn];
        }
        //保存所有按钮
        [_buttonList addObject:remarksDemoBtn];
    }];
    //中间文本输入框视图
    UITextView *textView = [[UITextView alloc]init];
    textView.delegate = self;
    [self.view addSubview:textView];
    _textView = textView;
   
    // textview 改变字体的行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    // 字体的行间距
    paragraphStyle.lineSpacing = 5;
    //隐藏文字
    UILabel *cautionLabel = [UILabel bee_labelWithText:@"给商家留言,可输入对商家的需求(可不填)" andColor:[UIColor grayColor] andFontSize:12];
    _cautionLabel = cautionLabel;
    [textView addSubview:cautionLabel];
    
    UILabel *rightLabel = [UILabel bee_labelWithText:@"300字以内" andColor:[UIColor grayColor] andFontSize:12];
    _rightLabel = rightLabel;
    [textView addSubview:rightLabel];
    //底部按钮
    UIButton *finishBtn = [UIButton bee_buttonWithTitle:@"完成" andFontSize:14 andNormalColor:[UIColor blackColor] andSelectedColor:nil];
    finishBtn.backgroundColor = [UIColor yellowColor];
    finishBtn.layer.cornerRadius = 5;
    [self.view addSubview:finishBtn];
    //点击事件
    [finishBtn addTarget:self action:@selector(finishChoose) forControlEvents:UIControlEventTouchUpInside];
    //设置约束
    [topV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(100);
    }];
    //按钮布局
    [_arry_one mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:15 leadSpacing:20 tailSpacing:20];
    [_arry_one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topV).offset(25);
        make.height.mas_equalTo(20);
    }];
    
    [_arry_two mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:15 leadSpacing:20 tailSpacing:20];
    [_arry_two mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_currentBtn.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];
    //输入文本
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(topV.mas_bottom).offset(1);
        make.height.mas_equalTo(150);
    }];
    
    //隐藏文字
    [cautionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(textView).offset(10);
    }];
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(textView).offset(75);
    }];
    //完成按钮
    [finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(textView.mas_bottom).offset(30);
    }];
    //传入写好的备注的文字
    if (_remarksInfo.length != 0 && ![_remarksInfo isEqualToString:@"其他要求(如带一包82年的雪碧)"]) {
        _textView.text = _remarksInfo;
        _cautionLabel.hidden = YES;
        _rightLabel.hidden = YES;
    }
}
#pragma mark -UITextViewDelegate
//文本内容变化
-(void)textViewDidChange:(UITextView *)textView{
    //获取内容
    NSString *container = textView.text;
    //将字符串分割成字符串数组
    NSArray <NSString *>*strArry = [container componentsSeparatedByString:@" "];
    //遍历备用数组和文本框内的数组
    for (int i = 0; i < _remarksArry.count; i++) {
        for (int j = 0; j < strArry.count; j++) {
            //判断内容是否一致
            if (![_remarksArry[i] isEqualToString:strArry[j]]) {
                _buttonList[i].enabled = YES;
            }
        }
    }
}


//设置有文字隐藏,没有文字显示
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if(![text isEqualToString:@""]){
        _cautionLabel.hidden = YES;
        _rightLabel.hidden = YES;
    }
    
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
        _cautionLabel.hidden = NO;
        _rightLabel.hidden = NO;
    }
    //限定字数
    if (range.location >= 300) {
        return NO;
    }
    
    return YES;
    
}
@end
