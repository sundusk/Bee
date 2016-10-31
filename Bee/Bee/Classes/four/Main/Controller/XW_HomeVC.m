//
//  LXWMainVC.m
//  NBApp
//
//  Created by yaoshuai on 16/9/6.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "XW_HomeVC.h"
#import "DSHTTPClient.h"
#import "LW_MainVC.h"
#import "XW_FreshModel.h"
#import "XW_ActivitiesModel.h"
#import "XW_IconsModel.h"
#import "XW_FocusModel.h"
#import "XW_HomeFlowLayout.h"
#import "XW_HomeCollectionViewCell.h"
#import "SDCycleScrollView.h"
#import "XW_ClassificationView.h"
#import "XW_FreshCollectionViewCell.h"
#import "XW_WebViewController.h"
#import "CQ_HistoryViewController.h"
#import "MG_DetailsViewController.h"
#import "SCanQRCodeViewController.h"
#import "DQ_SelectedGoods.h"

@interface XW_HomeVC ()<UICollectionViewDataSource,UICollectionViewDelegate,SDCycleScrollViewDelegate,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate,XW_IconsModellDelegate>

@end

@implementation XW_HomeVC
{
    //轮播器
    NSArray *_focusList;
    //列表
    NSArray *_activitiesList;
    //分类
    NSArray *_iconsList;
    //新鲜热卖
    NSArray *_freshList;
    // 是否隐藏顶部状态栏
    BOOL IsHideStstusBar;
    //UICollectionView全局
    UICollectionView *_homeCollectionView;
    //全局单例模型数组
    NSMutableArray <XW_FreshModel *>*_selectedModelList;
    //计算购物车表示
    int _num;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [_homeCollectionView reloadData];
}

#pragma mark -商品加的通知
-(void)addProducts:(NSNotification *)notification{
    UITabBarItem *tabBarItem = [[[self.tabBarController tabBar] items] objectAtIndex:2];
    _num = tabBarItem.badgeValue.intValue;
    _num ++;
    [tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", _num]];

    
    //获取模型
    XW_FreshModel *model = notification.object;
    __block NSInteger index = -1;
    [_selectedModelList enumerateObjectsUsingBlock:^(XW_FreshModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([model.name isEqualToString:obj.name]) {
            index = idx;
        }
    }];
    if (index == -1) {
        [_selectedModelList addObject:model];
    }else{
        _selectedModelList[index].orderCount++;
    }
//    //数组内没有商品则添加模型
//    __block NSInteger index = -1;
//    [_selectedModelList enumerateObjectsUsingBlock:^(XW_FreshModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([model.name isEqualToString:obj.name]) {
//            index = idx;
//        }
//    }];
//    if (index == -1) {
//        [_selectedModelList addObject:model];
//    }else{
//        _selectedModelList[index].orderCount++;
//    }
//    if (_selectedModelList.count == 0) {
//        [_selectedModelList addObject:model];
//    }else{
//        [_selectedModelList enumerateObjectsUsingBlock:^(XW_FreshModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            if ([model.name isEqualToString:obj.name]) {
//                index = idx;
////                [_selectedModelList addObject:model];
//            }
//        }];
//        _selectedModelList[index].orderCount++;
//    }
//    [_homeCollectionView reloadData];
}

#pragma mark -商品减的通知
-(void)reduceProdcts:(NSNotification *)notification{
    UITabBarItem *tabBarItem = [[[self.tabBarController tabBar] items] objectAtIndex:2];
    _num = tabBarItem.badgeValue.intValue;
    _num--;
    [tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", _num]];
    //获取模型
    XW_FreshModel *model = notification.object;
//    model.orderCount--;
    //商品数量为0移除
    if (model.orderCount == 0) {
        [_selectedModelList removeObject:model];
    }
    if (_num <= 0) {
        tabBarItem.badgeValue = nil;
    }

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _selectedModelList = [DQ_SelectedGoods sharedSelectedGoods].selectedGoodsArry;
    //注册商品加减的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addProducts:) name:@"addProducts" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reduceProdcts:) name:@"reduceProdcts" object:nil];
    [self demo];
    _focusList = [[NSArray alloc]init];
    //加载首页数据
    [self loadHomePageData];
    //测试新特性界面
    //设置界面
    [self setupUI];
}

#pragma mark - 设置UI界面
- (void)setupUI{
    
    UIView *searchViwe = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 25, 50)];
    UIBarButtonItem *searchItm = [[UIBarButtonItem alloc]initWithCustomView:searchViwe];
    UIButton *searchButton = [[UIButton alloc]init];
    NSAttributedString *searchStr = [NSAttributedString bee_imageTextWithImage:[UIImage imageNamed:@"icon_search"] imageWH:20 title:@"搜索" fontSize:10 titleColor:[UIColor blackColor] spacing:3];
    [searchButton setAttributedTitle:searchStr forState:UIControlStateNormal];
    searchButton.titleLabel.numberOfLines = 0;
    searchButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [searchButton sizeToFit];
    [searchViwe addSubview:searchButton];
    [searchButton addTarget:self action:@selector(jumpToSearchVC) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = searchItm;
    
    UIView *sweepViwe = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 25, 50)];
    UIBarButtonItem *sweepItm = [[UIBarButtonItem alloc]initWithCustomView:sweepViwe];
    UIButton *sweepButton = [[UIButton alloc]init];
    NSAttributedString *sweepStr = [NSAttributedString bee_imageTextWithImage:[UIImage imageNamed:@"icon_black_scancode"] imageWH:20 title:@"扫一扫" fontSize:10 titleColor:[UIColor blackColor] spacing:3];
    [sweepButton setAttributedTitle:sweepStr forState:UIControlStateNormal];
    sweepButton.titleLabel.numberOfLines = 0;
    sweepButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [sweepButton sizeToFit];
    [sweepViwe addSubview:sweepButton];
    [sweepButton addTarget:self action:@selector(jumpToSweepVC) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = sweepItm;
    
    
    //MARK:- 添加CollectionView视图
    XW_HomeFlowLayout *homeFlowLayout = [[XW_HomeFlowLayout alloc]init];
    UICollectionView *homeCollectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:homeFlowLayout];
    [self.view addSubview:homeCollectionView];
    homeCollectionView.dataSource = self;
    homeCollectionView.delegate = self;
    
    homeCollectionView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    homeFlowLayout.headerReferenceSize = CGSizeMake(self.view.size.width, 200);
    
    [homeCollectionView registerClass:[XW_HomeCollectionViewCell class] forCellWithReuseIdentifier:@"HomeCell"];
    
    [homeCollectionView registerClass:[XW_FreshCollectionViewCell class] forCellWithReuseIdentifier:@"HomeFreshCell"];
    
    [homeCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeHeaderCell"];
    _homeCollectionView = homeCollectionView;
    homeCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 65, 0);
    
}
#pragma mark - UICollectionViewDataSource代理方法实现
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return _activitiesList.count;
    }else {
        return _freshList.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        XW_HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCell" forIndexPath:indexPath];
        cell.activitiesModel = _activitiesList[indexPath.item];
        return cell;
    }
    XW_FreshCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeFreshCell" forIndexPath:indexPath];
    cell.freshModel = _freshList[indexPath.item];
    return cell;
}

#pragma mark - 设置UICollectionView的headerView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeHeaderCell" forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *imageArrayM = [NSMutableArray array];
    for (NSInteger i = 0; i < _focusList.count; i++) {
        NSString *url = ((XW_FocusModel *)_focusList[i]).img;
        [imageArrayM addObject:url];
    }
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 140) delegate:self placeholderImage:nil];
    cycleScrollView.imageURLStringsGroup = imageArrayM.copy;
    [headerView addSubview:cycleScrollView];
    
    //MARK:- 添加4个按钮
    XW_ClassificationView *buttonView = [[XW_ClassificationView alloc] initWithFrame:CGRectMake(0, 140, self.view.bounds.size.width,80)];
    buttonView.delegate = self;
    [headerView addSubview:buttonView];
    
    return headerView;
}

#pragma mark - 轮播器代理方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    [super viewDidLoad];
    XW_WebViewController *webViewController = [[XW_WebViewController alloc]init];
    webViewController.jumpString = ((XW_FocusModel *)_focusList[index]).toURL;
    [self.navigationController pushViewController:webViewController animated:YES];
}

#pragma mark - collectionViewDelegateFlowLayout方法
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(collectionView.bounds.size.width - 10, 140);
    }
    return CGSizeMake((collectionView.bounds.size.width * 0.5 - 10) , 220);
}

#pragma mark - 设置组头高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(self.view.frame.size.width, 220);
    }else {
        return CGSizeMake(0, 0);
    }
}

#pragma mark - 首页界面跳转到详情和webView
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        XW_WebViewController *webViewController = [[XW_WebViewController alloc]init];
        webViewController.jumpString = ((XW_ActivitiesModel *)_activitiesList[indexPath.row]).customURL;
        [self.navigationController pushViewController:webViewController animated:YES];
    }else{
        MG_DetailsViewController *detailsViewController = [[MG_DetailsViewController alloc]init];
        detailsViewController.freshModel = _freshList[indexPath.item];
        [self.navigationController pushViewController:detailsViewController animated:YES];
    }
}

#pragma mark - 跳到搜索
- (void)jumpToSearchVC{
    CQ_HistoryViewController *historyViewController = [[CQ_HistoryViewController alloc]init];
    [self.navigationController pushViewController:historyViewController animated:YES];
}

#pragma mark - 加载数据
- (void)loadHomePageData{
    
    //MARK:- 加载焦点数据
    NSMutableDictionary *param1 = [NSMutableDictionary dictionary];
    
    [param1 setValue:@"1" forKey:@"call"];
    
    [DSHTTPClient postUrlString:@"focus.json.php" withParam:param1 withSuccessBlock:^(id data) {
        //MARK:- 解析轮播器数据
        NSArray *focusArr = data[@"data"][@"focus"];
        NSMutableArray *focusM = [NSMutableArray arrayWithCapacity:focusArr.count];
        [focusArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            XW_FocusModel *focusModel = [XW_FocusModel  newsWithDict:obj];
            
            [focusM addObject:focusModel];
        }];
        _focusList = focusM.copy;
        
        //MARK:- 解析列表数据
        NSArray *activitiesArr = data[@"data"][@"activities"];
        NSMutableArray *activitiesM = [NSMutableArray arrayWithCapacity:activitiesArr.count];
        [activitiesArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            XW_ActivitiesModel *activitiesModel = [XW_ActivitiesModel  newsWithDict:obj];
            
            [activitiesM addObject:activitiesModel];
        }];
        _activitiesList = activitiesM.copy;
        
        //MARK:- 解析分类数据
        NSArray *iconsArr = data[@"data"][@"icons"];
        NSMutableArray *iconsM = [NSMutableArray arrayWithCapacity:iconsArr.count];
        [iconsArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            XW_IconsModel *iconsModel = [XW_IconsModel  newsWithDict:obj];
            
            [iconsM addObject:iconsModel];
        }];
        _iconsList = iconsM.copy;
        
    } withFailedBlock:^(NSError *error) {
        NSLog(@"%@",error);
    } withErrorBlock:^(NSString *message) {
        NSLog(@"%@",message);
    }];
    
    //MARK:- 首页新鲜热卖数据加载
    NSMutableDictionary *param2 = [NSMutableDictionary dictionary];
    
    [param2 setValue:@"2" forKey:@"call"];
    //调用方法
    [DSHTTPClient postUrlString:@"firstSell.json.php" withParam:param2 withSuccessBlock:^(id data) {
        
        NSArray *freshArr = data[@"data"];
        
        NSMutableArray *freshM = [NSMutableArray arrayWithCapacity:freshArr.count];
        [freshArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            XW_FreshModel *freshModel = [XW_FreshModel newsWithDict:obj];
            [freshM addObject:freshModel];
        }];
        _freshList = freshM.copy;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [_homeCollectionView reloadData];
        }];
        
    } withFailedBlock:^(NSError *error) {
        NSLog(@"%@",error);
    } withErrorBlock:^(NSString *message) {
        NSLog(@"%@",message);
    }];
}

#pragma mark -  按钮跳转webV代理方法
-(void)jumpToVC:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
        {
            [self buttonJumpToWebVeiw:sender.tag];
        }
            break;
        case 2:
        {
            [self buttonJumpToWebVeiw:sender.tag];
        }
            break;
        case 3:
        {
            [self buttonJumpToWebVeiw:sender.tag];
        }
            break;
        case 4:
        {
            [self buttonJumpToWebVeiw:sender.tag];
        }
        default:
            break;
    }
}

#pragma mark -按钮跳转webV方法的抽取
- (void)buttonJumpToWebVeiw:(NSInteger)tag{
    XW_WebViewController *webVC = [[XW_WebViewController alloc]init];
    webVC.jumpString = ((XW_IconsModel *)_iconsList[tag - 1]).customURL;
    
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - 跳转扫一扫界面
- (void)jumpToSweepVC{
    SCanQRCodeViewController *scan = [[SCanQRCodeViewController alloc] init];
    [self.navigationController pushViewController:scan animated:YES];
}

#pragma mark - 新特性界面测试区
- (void)demo{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults valueForKey:@"time"]) {
        [defaults setValue:@"sd" forKey:@"time"];
    }else{
        UIImageView *advertisemenView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guide_40_4"]];
        [UIImageView animateWithDuration:1 delay:2 options:0 animations:^{
            advertisemenView.transform = CGAffineTransformMakeScale(1,1);
            advertisemenView.alpha = 0;
        } completion:^(BOOL finished) {
            [advertisemenView removeFromSuperview];
        }];
    }
    
}
- (BOOL)prefersStatusBarHidden{
    return IsHideStstusBar;
}

- (void)text1{
    self.tabBarController.tabBar.hidden = NO;
    IsHideStstusBar = NO;
    [self setNeedsStatusBarAppearanceUpdate];
    self.navigationController.navigationBar.hidden = NO;
}
@end