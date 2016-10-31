//
//  DQMainVC.m
//  NBApp
//
//  Created by yaoshuai on 16/9/6.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "DQ_MainVC.h"
#import "LW_MainVC.h"
#import "CQ_CarVC.h"
#import "DQ_BlankView.h"
#import "XW_HomeVC.h"
#import "DQ_GoodsView.h"
#import "DQ_GoodsCell.h"
#import "DQ_AddressTableViewController.h"
#import "DQ_MarkIconCell.h"
#import "DQ_GetGoodsTimeCell.h"
#import "DQ_ShowGoodsCell.h"
#import "DQ_RemarkCell.h"
#import "DQ_PayCell.h"
#import "DQ_RemarksViewController.h"
#import "DQ_AddressModel.h"
#import "MG_DetailsViewController.h"
#import "YS_TabbarVC.h"
#import "YQ_ChaoShiVC.h"
#import "LW_LoginVC.h"
#import "XW_FreshModel.h"
#import "HcdDateTimePickerView.h"
#import "DQ_SelectedGoods.h"

//地址cell
static NSString *Address_Cell = @"Address_Cell";
//超市cell
static NSString *MarkIconCell = @"DQ_MarkIconCell";
//收货时间cell
static NSString *GetGoodsTimeCell = @"GetGoodsTimeCell";
//商品展示cell
static NSString *ShowGoodsCell = @"ShowGoodsCell";
//备注cell
static NSString *RemarkCell = @"RemarkCell";
//底部计算价格付款cell
static NSString *PayCell = @"PayCell";
@interface DQ_MainVC ()<DQ_BlankViewDelegate,UITableViewDataSource,UITableViewDelegate>
//全局的tableView
@property(strong,nonatomic)DQ_GoodsView *goodsView;
//地址模型全局化
@property(strong,nonatomic)DQ_AddressModel *addressModel;

@end

@implementation DQ_MainVC{
    //记录cell行号
    NSInteger _indexPathRow;
    //记录商品展示cell的按钮状态
    NSMutableArray <UIButton *>*_selectedBtnArry;
    //计算商品初始总价
    float _totalPrice;
    //选中商品总价
    float _payForPrice;
    //实际选中的商品数组模型
    NSMutableArray <XW_FreshModel *>*_payForModelArry;
    //时间选择
    HcdDateTimePickerView * _dateTimePickerView;
    //全局单例模型数组
    NSMutableArray <XW_FreshModel *>*_selectedModelsArry;
    //接收备注信息
    NSString *_remarksInfo;
}

#pragma mark -没有登录不能载入界面
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    if([[LW_LoginVC phoneNum] isEmpty])// 没有登录
    {
        LW_LoginVC *loginVC = [[LW_LoginVC alloc] init];
        loginVC.block = ^{ self.navigationController.tabBarController.selectedIndex = 0;
        };
        [self presentViewController:loginVC animated:YES completion:nil];
    }
    //视图将要显示时判断加载哪个视图
    if (_selectedModelsArry.count == 0) {
        [_goodsView removeFromSuperview];
        [self setupBlankView];
    }else{
        [self setupGoodsView];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _selectedModelsArry = [DQ_SelectedGoods sharedSelectedGoods].selectedGoodsArry;
    //实例化按钮数组
    _selectedBtnArry = [NSMutableArray array];
    _payForModelArry = [NSMutableArray array];
    //注册付款通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePayInfo:) name:@"selectedAllBtnClick" object:nil];
    //注册每个商品展示的按钮通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSelectedGoos:) name:@"selectedBtnClick" object:nil];
    //注册付款按钮跳转的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToPayVC:) name:@"goToPayVC" object:nil];
    //监听展示地址通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShowAddress:) name:@"ShowAddress" object:nil];
    //菜品增加
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AddGoods:) name:@"AddGoods" object:nil];
    //菜品减少
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ReduceGoods:) name:@"ReduceGoods" object:nil];
    //监听地址数量变化的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AddressCount:) name:@"AddressCount" object:nil];
    //监听输入备注完成的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishChoose:) name:@"finishChoose" object:nil];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark -备注信息通知
-(void)finishChoose:(NSNotification *)notification{
    //获取回调的字符串
    _remarksInfo = notification.object;
    [_goodsView reloadData];
}

#pragma mark -监听地址数量变化的通知
-(void)AddressCount:(NSNotification *)notification{
    //获取传入的模型数组
    NSMutableArray <DQ_AddressModel *>*addressArry = notification.object;
    //判断,数组为0
    if(addressArry.count == 0){
        _addressModel = nil;
    }
}


#pragma mark -监听按钮全选,更新付款按钮状态
-(void)changePayInfo:(NSNotification *)notification{
    UIButton *selectedAllBtn = notification.object;
    //判断全选按钮的状态
    if (selectedAllBtn.selected == YES) {
        _payForPrice = _totalPrice;
        _totalPrice = 0;
    }else{
        _totalPrice = _payForPrice;
    }
    [_goodsView reloadData];
}

#pragma mark -增加商品
-(void)AddGoods:(NSNotification *)notification{
    //接收商品模型
    XW_FreshModel *model = notification.object;
    _totalPrice += model.partner_price.floatValue;
    [_goodsView reloadData];
}

#pragma mark -减少商品
-(void)ReduceGoods:(NSNotification *)notification{
    //接收商品模型
    XW_FreshModel *model = notification.object;
    _totalPrice -= model.partner_price.floatValue;
    if (model.orderCount == 0) {
        [_selectedModelsArry removeObject:model];
    }
    //模型数组为空时移除视图
    if (_selectedModelsArry.count == 0) {
        [_goodsView removeFromSuperview];
        [self setupBlankView];
    }
    [_goodsView reloadData];
}

#pragma mark -设置有商品的界面
-(void)setupGoodsView{
    //刚进入时计算初始价格
    _totalPrice = 0;
    [_selectedModelsArry enumerateObjectsUsingBlock:^(XW_FreshModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        _totalPrice += obj.partner_price.floatValue * obj.orderCount * 1.0;
    }];
    //1.加载自定义tableView
    _goodsView = [[DQ_GoodsView alloc]init];
    _goodsView.frame = CGRectMake(0, -20, self.view.frame.size.width,self.view.frame.size.height - 24);
    [self.view addSubview:_goodsView];
    //2.设置代理
    _goodsView.dataSource = self;
    _goodsView.delegate = self;
    //3.注册cell
    [_goodsView registerClass:[DQ_GoodsCell class] forCellReuseIdentifier:Address_Cell];
    [_goodsView registerClass:[DQ_MarkIconCell class] forCellReuseIdentifier:MarkIconCell];
    [_goodsView registerClass:[DQ_GetGoodsTimeCell class] forCellReuseIdentifier:GetGoodsTimeCell];
    [_goodsView registerClass:[DQ_ShowGoodsCell class] forCellReuseIdentifier:ShowGoodsCell];
    [_goodsView registerClass:[DQ_RemarkCell class] forCellReuseIdentifier:RemarkCell];
    [_goodsView registerClass:[DQ_PayCell class] forCellReuseIdentifier:PayCell];
    //4.自动计算行高
    _goodsView.estimatedRowHeight = 100.0;
    _goodsView.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark -UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    };
    return 4+_selectedModelsArry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        DQ_GoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:Address_Cell forIndexPath:indexPath];
        cell.addressModel = _addressModel;
        return cell;
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        return [tableView dequeueReusableCellWithIdentifier:MarkIconCell forIndexPath:indexPath];
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        return [tableView dequeueReusableCellWithIdentifier:GetGoodsTimeCell forIndexPath:indexPath];
    }
    //第一组第三行开始,遍历传入的数组模型,展示商品列表
    for (NSInteger i = 0; i < _selectedModelsArry.count; i++) {
        if (indexPath.section == 1 && indexPath.row == i+2) {
            DQ_ShowGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:ShowGoodsCell forIndexPath:indexPath];
            cell.model = _selectedModelsArry[i];
            return cell;
        }
    }
    //商品列表之后展示备注
    if (indexPath.section == 1 && indexPath.row == 2 + _selectedModelsArry.count) {
        DQ_RemarkCell *cell = [tableView dequeueReusableCellWithIdentifier:RemarkCell forIndexPath:indexPath];
        cell.detailLabel.text = _remarksInfo;
        return cell;
    }
    //价格合计
    DQ_PayCell *cell = [tableView dequeueReusableCellWithIdentifier:PayCell forIndexPath:indexPath];
    cell.selectedAllBtn.selected = [self getSelectedButtonState];
    cell.payBtn.selected = [self getCancelButtonState];
    cell.totalPrice = _totalPrice;
    return cell;
}

#pragma mark -刷新地址的通知
-(void)ShowAddress:(NSNotification *)notification{
    //获取回调的模型
    _addressModel = notification.object;
    [_goodsView reloadData];
}

#pragma mark -付款按钮通知跳转页面
-(void)goToPayVC:(NSNotification *)notification{
    //获取cell
    DQ_PayCell *cell = notification.object;
    if (cell.payBtn.selected == NO) {
        CQ_CarVC *vc = [[CQ_CarVC alloc]init];
        //将默认数组和选中数组比较,个数一样则随意,如果不一样则传出选中数组
        if (_selectedModelsArry.count == _payForModelArry.count) {
            //传出默认模型数组
            vc.commodity = _selectedModelsArry;
            vc.allNum = _totalPrice;
        }else{
            //传出选中模型数组
            vc.commodity = _selectedModelsArry;
            vc.allNum = _totalPrice;
        }
        //传出商品总价
        [self.navigationController pushViewController:vc animated:YES];
    }
   
}

#pragma mark -监听商品展示界面按钮的通知
-(void)getSelectedGoos:(NSNotification *)notification{
    //保存按钮的选中状态
    DQ_ShowGoodsCell *cell = notification.object;
    if (![_selectedBtnArry containsObject:cell.selectedBtn]) {
        [_selectedBtnArry addObject:cell.selectedBtn];
    }
    //根据按钮的选中状态计算总价
    if (cell.selectedBtn.selected == NO) {
         _totalPrice += cell.model.orderCount * cell.model.partner_price.floatValue * 1.0;
    }else{
         _totalPrice -= cell.model.orderCount * cell.model.partner_price.floatValue * 1.0;
    }
    //将选中的菜品模型和数组中的元素比较,如果有就保存
    if ([_selectedModelsArry containsObject:cell.model]) {
        [_payForModelArry addObject:cell.model];
    }
    //刷新界面
    [_goodsView reloadData];
}

#pragma mark -判断商品展示界面按钮的选中
-(BOOL)getSelectedButtonState{
    for (NSInteger i = 0; i < _selectedBtnArry.count; i++) {
        if (_selectedBtnArry[i].selected == YES) {
            //当有一个按钮为选中状态,全选按钮就为选中状态
            return YES;
        }
    }
    //当所有按钮都为普通状态,全选按钮才为普通状态
    return NO;
}

#pragma mark -判断是否取消全部选中
-(BOOL)getCancelButtonState{
    for (NSInteger i = 0; i < _selectedBtnArry.count; i++) {
        if (_selectedBtnArry[i].selected == YES && [self getSelectedButtonState] == YES) {
            return YES;
        }
    }
    return NO;
}

#pragma mark -UITableViewDelegate
//MARK: -监听选中
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DQ_AddressTableViewController *addressVC = [[DQ_AddressTableViewController alloc]init];
    DQ_RemarksViewController *remarksVC = [[DQ_RemarksViewController alloc]init];
    MG_DetailsViewController *detailVC = [[MG_DetailsViewController alloc]init];
    //跳转到编辑地址VC
    if (indexPath.section == 0) {
        [self.navigationController pushViewController:addressVC animated:YES];
    }
    //选择时间
    if (indexPath.section == 1 && indexPath.row == 1) {
        //获取cell
        DQ_GetGoodsTimeCell *cell = [_goodsView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
        _dateTimePickerView = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerDateHourMinuteMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:1000]];
        _dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
            
            cell.time = datetimeStr;
        };
        [_goodsView addSubview:_dateTimePickerView];
        [_dateTimePickerView showHcdDateTimePicker];
    }
    //跳转备注页面
    if (indexPath.section == 1 && indexPath.row == 2 + _selectedModelsArry.count){
        DQ_RemarkCell *cell = [_goodsView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 + _selectedModelsArry.count inSection:1]];
        remarksVC.remarksInfo = cell.detailLabel.text;
        [self.navigationController pushViewController:remarksVC animated:YES];
    }
    //跳物品详情
    if (indexPath.section == 1 && indexPath.row > 1 && indexPath.row < 2 + _selectedModelsArry.count) {
        //获取选中的cell的模型
        DQ_ShowGoodsCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        detailVC.productsModel = cell.model;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

#pragma mark -布局没有商品时的空白界面
- (void)setupBlankView
{
    //1.设置没有商品是的空白页面
    DQ_BlankView *blankView = [[DQ_BlankView alloc]init];
    blankView.frame = self.view.frame;
    [self.view addSubview:blankView];
    //1.1设置blankView的代理
    blankView.delegate = self;
}


#pragma mark -DQ_BlankViewDelegate
-(void)goToHomeViewController{
    self.tabBarController.selectedIndex = 0;
}

#pragma mark - 移除通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end