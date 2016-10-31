//
//  ZMGMainVC.m
//  NBApp
//
//  Created by yaoshuai on 16/9/6.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "MG_MainVC.h"
#import "MG_HeaderView.h"
#import "MG_MyTopCell.h"
#import "LW_LoginVC.h"


#define firstCellID @"firstCellID"
#define comCellID @"comCellID"

static NSInteger cellIndex;

@interface MG_MainVC ()<UITableViewDataSource, UITableViewDelegate, MG_MyTopCellDelegate>
{
    NSArray<NSDictionary *> *_cellDictArr;
    NSArray *_cellNums;
}
@end

@implementation MG_MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"";
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[MG_MyTopCell class] forCellReuseIdentifier:firstCellID];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:comCellID];
    
    [self setupHeaderView];
    
    _cellDictArr = @[
                     @{@"icon":@"v2_my_address_icon",@"desc":@"我的收货地址",@"vc":@"DQ_AddressTableViewController"},
                     @{@"icon":@"icon_mystore",@"desc":@"我的店铺",@"vc":@"YS_MyShopVC"},
                     @{@"icon":@"v2_my_share_icon",@"desc":@"把爱鲜蜂分享给朋友",@"vc":@"shared"},
                     @{@"icon":@"v2_my_serviceonline_icon",@"desc":@"客服帮助",@"vc":@"YS_HelpVC"},
                     @{@"icon":@"v2_my_feedback_icon",@"desc":@"意见反馈",@"vc":@"YS_FeedbackVC"},
                     @{@"icon":@"v2_my_feedback_icon",@"desc":@"设置手势解锁",@"vc":@"HMGestureUnlockController"}
                     ];
    _cellNums = @[@1,@2,@1,@3];
}
- (void)demo{
    NSLog(@"hello boy");
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if([[LW_LoginVC phoneNum] isEmpty])// 没有登录
    {
        LW_LoginVC *loginVC = [[LW_LoginVC alloc] init];
        loginVC.block = ^{
            self.navigationController.tabBarController.selectedIndex = 0;
        };
        [self presentViewController:loginVC animated:YES completion:nil];
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - 表头页面

- (void)setupHeaderView
{
    MG_HeaderView *headV = [[MG_HeaderView alloc] init];
    headV.frame = CGRectMake(0, 0, self.view.width, 150);
    self.tableView.tableHeaderView = headV;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _cellNums.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_cellNums[section] integerValue];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            cellIndex = 0;
            MG_MyTopCell *firstCell = [tableView dequeueReusableCellWithIdentifier:firstCellID forIndexPath:indexPath];
            firstCell.delegate = self;
            return firstCell;
        }
        default:
        {
            NSDictionary *dict = _cellDictArr[cellIndex++];
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:comCellID forIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.imageView.image = [UIImage imageNamed:dict[@"icon"]];
            cell.textLabel.text = dict[@"desc"];
            
            return cell;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 80;
        default:
            return 50;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 0;
        default:
            return 15;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    __block NSInteger dictIdx = 0;
    [_cellNums enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(idx < indexPath.section && idx > 0)
        {
            dictIdx += [obj integerValue];
        }
        else if(idx == indexPath.section)
        {
            dictIdx += indexPath.row;
        }
    }];
    
    NSDictionary *dict = _cellDictArr[dictIdx];
    if([dict[@"vc"] isEqualToString:@"shared"])// 分享
    {
        [self shared];
    }
    else// 跳转
    {
        UIViewController *vc = [[NSClassFromString(dict[@"vc"]) alloc] init];
        NSString *errMsg = [NSString stringWithFormat:@"%@不是控制器",dict[@"vc"]];
        NSAssert([vc isKindOfClass:[UIViewController class]], errMsg);
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - MG_MyTopCellDelegate
- (void)topCellJumpToVC:(NSString *)vcName
{
    UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
    NSString *errMsg = [NSString stringWithFormat:@"%@不是控制器类",vcName];
    NSAssert([vc isKindOfClass:[UIViewController class]], errMsg);
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 分享
- (void)shared
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"分享到" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"微信好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *act2 = [UIAlertAction actionWithTitle:@"微信朋友圈" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *act3 = [UIAlertAction actionWithTitle:@"新浪微博" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *act4 = [UIAlertAction actionWithTitle:@"QQ空间" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *actcancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:act1];
    [alertVC addAction:act2];
    [alertVC addAction:act3];
    [alertVC addAction:act4];
    [alertVC addAction:actcancel];
    
    [self presentViewController:alertVC animated:YES completion:^{
        
    }];
}

#pragma mark - 隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end