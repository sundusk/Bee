//
//  YS_QuanVC.m
//  Bee
//
//  Created by yaoshuai on 16/9/9.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "YS_QuanVC.h"
#import "YS_QuanModel.h"
#import "DSHTTPClient.h"
#import "YYModel.h"
#import "YS_QuanCell.h"

#define cellID @"cellID"

@interface YS_QuanVC ()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray<YS_QuanModel *> *_modelArray;
}
@property (weak, nonatomic) UITextField *haomaField;
@property (weak, nonatomic) UIButton *bindBtn;
@property (weak, nonatomic) UILabel *separLineLabel;
@property (weak, nonatomic) UITableView *quanTB;
@end

@implementation YS_QuanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"优惠券";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupTop];
    [self setupTableView];
    
    [self loadData];
}

#pragma mark - 布局界面
- (void)setupTop
{
    UITextField *txtField = [[UITextField alloc] init];
    UIButton *bindBtn = [[UIButton alloc] init];
    UILabel *separLabel = [[UILabel alloc] init];
    
    [self.view addSubview:txtField];
    [self.view addSubview:bindBtn];
    [self.view addSubview:separLabel];
    
    _haomaField = txtField;
    _bindBtn = bindBtn;
    _separLineLabel = separLabel;
    
    // 设置控件属性
    txtField.placeholder = @"请输入优惠券号码";
    txtField.borderStyle = UITextBorderStyleRoundedRect;
    
    [bindBtn setTitle:@"绑定" forState:UIControlStateNormal];
    [bindBtn setBackgroundColor:[UIColor orangeColor]];
    bindBtn.layer.cornerRadius = 5;
    bindBtn.layer.masksToBounds = YES;
    
    separLabel.backgroundColor = [UIColor lightGrayColor];
    // 设置控件约束
    [txtField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.offset(10);
        make.height.offset(30);
        make.width.offset(250);
    }];
    [bindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(txtField);
        make.left.equalTo(txtField.mas_right).offset(10);
        make.height.equalTo(txtField);
        make.right.offset(-10);
    }];
    [separLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(txtField.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];
}
- (void)setupTableView
{
    UITableView *tb = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:tb];
    _quanTB = tb;
    
    // 设置控件属性
    tb.dataSource = self;
    tb.delegate = self;
    [tb registerClass:[YS_QuanCell class] forCellReuseIdentifier:cellID];
    tb.estimatedRowHeight = 100;
    tb.rowHeight = UITableViewAutomaticDimension;
    tb.separatorStyle = UITableViewCellSeparatorStyleNone;
    tb.showsVerticalScrollIndicator = NO;
    
    // 设置控件约束
    [tb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_haomaField);
        make.right.equalTo(_bindBtn);
        make.top.equalTo(_separLineLabel.mas_bottom).offset(5);
        make.bottom.equalTo(self.view);
    }];
}

#pragma mark - 加载数据
- (void)loadData
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"9" forKey:@"call"];
    
    [DSHTTPClient postUrlString:@"MyCoupon.json.php" withParam:param withSuccessBlock:^(NSDictionary *data) {
        
        NSArray<NSDictionary *> *dictArr = data[@"data"];
        NSMutableArray<YS_QuanModel *> *modelArrayM = [NSMutableArray array];
        
        [dictArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YS_QuanModel *model = [[YS_QuanModel alloc] init];
            [model setValuesForKeysWithDictionary:obj];
            [modelArrayM addObject:model];
        }];
        
        _modelArray = modelArrayM.copy;
        
        [_quanTB reloadData];
        
    } withFailedBlock:^(NSError *error) {
        NSLog(@"%@",error);
    } withErrorBlock:^(NSString *message) {
        NSLog(@"%@",message);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _modelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YS_QuanCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    YS_QuanModel *model = _modelArray[indexPath.row];
    cell.quanModel = model;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end