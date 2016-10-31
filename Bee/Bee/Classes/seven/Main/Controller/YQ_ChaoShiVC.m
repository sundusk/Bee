//
//  YQ_ChaoShiVC.m
//  Bee
//
//  Created by yaoshuai on 16/9/7.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "YQ_ChaoShiVC.h"
#import "DSHTTPClient.h"
#import "YQ_CategoryModel.h"
#import "YQ_CategoryCell.h"
#import "YQ_ProductsCell.h"
#import "YYModel.h"
#import "MG_DetailsViewController.h"
#import "BeeSVProgressHUD.h"
#import "YQ_ProductsHeaderView.h"
#import "CQ_HistoryViewController.h"
#import "SCanQRCodeViewController.h"
#import "XW_FreshModel.h"
#import "MJRefresh.h"
#import "DQ_SelectedGoods.h"

static NSString *CategoryCellID = @"CategoryCellID";
static NSString *ProductsCellID = @"ProductsCell";

/**
 *  header的重用标识符
 */
static NSString *headerID = @"headerID";

@interface YQ_ChaoShiVC () <UITableViewDataSource, UITableViewDelegate, YQ_ProductsCellDelegate>

/**
 *  分类列表视图
 */
@property(weak, nonatomic) UITableView *tvCategory;

/**
 *  产品列表视图
 */
@property(weak, nonatomic) UITableView *tvProducts;

/**
 *  产品字典
 */
@property(strong, nonatomic) NSDictionary *productsDict;

/**
 *  已点击的产品模型字典
 */
@property(strong, nonatomic) NSMutableDictionary *productsModelDict;

/**
 *  用来保存分类索引
 */
@property(assign, nonatomic) NSIndexPath *categoryIndex;

/**
 *  保存所有已经被用户选择产品模型
 */
@property(strong, nonatomic) NSMutableArray *carList;

@end

@implementation YQ_ChaoShiVC {
    
    /**
     *  分类列表的数据源数组
     */
    NSArray<YQ_CategoryModel *> *_categoryList;
    
    /**
     *  产品列表的数据源数组
     */
    NSArray<XW_FreshModel *> *_productsList;
    //全局单例数组
    NSMutableArray <XW_FreshModel *>*_selectedModelsArry;
    int num;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_tvProducts reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectedModelsArry = [DQ_SelectedGoods sharedSelectedGoods].selectedGoodsArry;
    //初始化
    num = 0;
    //设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadSupermarketData];
    
    [BeeSVProgressHUD showWithStatus:@"正在加载..."];
    
    //添加UIBarButtonItem左右按钮
    UIImage *image1 = [[UIImage imageNamed:@"icon_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *search = [[UIBarButtonItem alloc]initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(jumpToSearchVC)];
    self.navigationItem.rightBarButtonItem = search;
    
    UIImage *image2 = [[UIImage imageNamed:@"icon_black_scancode"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *camera = [[UIBarButtonItem alloc]initWithImage:image2 style:UIBarButtonItemStylePlain target:self action:@selector(jumpToSweepVC)];
    self.navigationItem.leftBarButtonItem = camera;
    
    //实例化保存所有被用户选择的产品模型
    _carList = [NSMutableArray array];
    
    _productsModelDict = [NSMutableDictionary dictionary];
}

#pragma mark - 跳到搜索
- (void)jumpToSearchVC {
    CQ_HistoryViewController *historyViewController = [[CQ_HistoryViewController alloc]init];
    [self.navigationController pushViewController:historyViewController animated:YES];
}

#pragma mark - 跳到扫一扫
- (void)jumpToSweepVC {
    SCanQRCodeViewController *scan = [[SCanQRCodeViewController alloc] init];
    [self.navigationController pushViewController:scan animated:YES];
}

#pragma mark - YQ_ProductsCellDelegate
- (void)productsCell:(YQ_ProductsCell *)productsCell didFinishIncreseProducts:(XW_FreshModel *)productsModel andStartPoint:(CGPoint)startPoint animImageView:(UIImageView *)animImageView{
    
    [_productsModelDict setObject:productsModel forKey:productsModel.name];
    __block NSInteger index = -1;
    [_selectedModelsArry enumerateObjectsUsingBlock:^(XW_FreshModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([productsModel.name isEqualToString:obj.name]) {
            index = idx;
        }
    }];
        if (index == -1) {
            [_selectedModelsArry addObject:productsModel];
        }else{
            _selectedModelsArry[index].orderCount++;
        }
    
    //MARK: - 动画
    // - 1.添加图片框
    UIImageView *imgView = [[UIImageView alloc] initWithImage:animImageView.image];
    imgView.size = animImageView.size;
    
    // - 将图片框添加给窗口
    UIWindow *keyW = [UIApplication sharedApplication].keyWindow;
    [keyW addSubview:imgView];
    
    // - 2.开启核心动画,让图片框运动
    // 1.创建对象
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    // 通过kvc给动画绑定imgView
    [anim setValue:imgView forKey:@"imgV"];
    
    // 2.设置属性
    // 起始点
    CGPoint startP = CGPointMake(startPoint.x - 230, startPoint.y);
    // 结束点
    CGPoint endP = CGPointMake(235, keyW.bounds.size.height - 45);
    // 控制点
    CGPoint controlP = CGPointMake(250, keyW.bounds.size.height - 200);
    
    //设置动画
    [UIView animateWithDuration:1.4 animations:^{
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:startP];
        
        [path addQuadCurveToPoint:endP controlPoint:controlP];
        anim.path = path.CGPath;
        
        imgView.size = CGSizeZero;
    }];
    
    // 不让图片闪回去
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    
    // 设置动画时间
    anim.duration = 1;
    
    //设置动画的代理
    anim.delegate = self;
    
    // 3.添加
    [imgView.layer addAnimation:anim forKey:nil];
    
}

//核心动画的代理方法
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    //1. 取出图片框
    UIImageView *imgV = [anim valueForKey:@"imgV"];
    
    //2. 移除核心动画
    [imgV.layer removeAllAnimations];
    
    //3. 移除图片框
    [imgV removeFromSuperview];
}

- (void)productsCell:(YQ_ProductsCell *)productsCell didFinishReduceProducts:(XW_FreshModel *)productsModel {
    
    NSMutableArray <XW_FreshModel *>*arry = [DQ_SelectedGoods sharedSelectedGoods].selectedGoodsArry;

    if (productsModel.orderCount == 0) {
    [arry removeObject:productsModel];
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _tvCategory) {
        
        YQ_CategoryModel *categoryModel = _categoryList[indexPath.row];
        
        NSArray *productArr = [_productsDict objectForKeyedSubscript:categoryModel.id];
        
        // 使用YYModel实现字典转模型
        _productsList = [NSArray yy_modelArrayWithClass:[XW_FreshModel class] json:productArr].copy;
        
        self.categoryIndex = indexPath;
        
        // 点击后刷新产品列表的数据
        [self.tvProducts reloadData];
        
        // 让产品列表,选中第一行!
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
        [_tvProducts scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        return;
    }
    //点击cell跳转控制器
    MG_DetailsViewController *detailVC = [[MG_DetailsViewController alloc] init];
    detailVC.productsModel = _productsList[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

// 一定要设置组标题的高度,才会调用这个代理方法
// 此方法,负责返回每组header对应的视图!
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    //1. 如果是分类列表，直接返回
    if (tableView == _tvCategory) {
        return nil;
    }
    
    //2. 创建headerView
    YQ_ProductsHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    //3. 设置数据
    headerView.headerTitle = _categoryList[_categoryIndex.row].name;
    //4. 返回
    return headerView;
}

#pragma mark - UITableViewDataSource
//分类列表、产品列表的数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _tvCategory) {
        return _categoryList.count;
    }
    return _productsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = (tableView == _tvCategory) ? CategoryCellID : ProductsCellID;
    
    //1. 创建cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    //1.1 分类列表的cell
    if (tableView == _tvCategory) {
        //1.1.1 设置分类列表的数据
        ((YQ_CategoryCell *)cell).textLabel.text = _categoryList[indexPath.row].name;
        //1.1.2 返回cell
        return cell;
    }
    
    //1.2 产品的cell
    XW_FreshModel *productModel = _productsList[indexPath.row];
    
    XW_FreshModel *productModels = [_productsModelDict objectForKey:productModel.name];
    if (productModels) {
        productModel = productModels;
    }
    ((YQ_ProductsCell *)cell).productsModel = productModel;
    //MARK: - 4. 设置产品cell的代理
    ((YQ_ProductsCell *)cell).delegate = self;
    return cell;
}

#pragma mark - 加载数据
- (void)loadSupermarketData{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setValue:@"5" forKey:@"call"];
    
    [DSHTTPClient postUrlString:@"supermarket.json.php" withParam:param withSuccessBlock:^(id data) {
        
        //MARK: - 1、分类列表数据
        //1.1 获取分类列表数据
        NSArray<NSDictionary *> *categories = data[@"data"][@"categories"];
        
        //1.2 使用YYModel实现字典转模型
        _categoryList = [NSArray yy_modelArrayWithClass:[YQ_CategoryModel class] json:categories];
        
        //MARK: - 2、产品列表数据
        //2.1 获取产品列表字典
        _productsDict = data[@"data"][@"products"];
        
        //2.2 获取产品列表第一组数据
        NSArray *productArr = data[@"data"][@"products"][@"a106"];
        
        //2.3 使用YYModel实现字典转模型
        _productsList = [NSArray yy_modelArrayWithClass:[XW_FreshModel class] json:productArr].copy;
        
        //MARK: - 3、在主线程刷新列表的数据
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            [self setupUI];
            
            [BeeSVProgressHUD dismiss];
            
        }];
        
    } withFailedBlock:^(NSError *error) {
        NSLog(@"%@",error);
    } withErrorBlock:^(NSString *message) {
        NSLog(@"%@",message);
    }];
}

#pragma mark - 实现增加、减少产品的通知方法
- (void)increaseProductsNotification:(NSNotification *)notifi {
    UITabBarItem *tabBarItem = [[[self.tabBarController tabBar] items] objectAtIndex:2];
    num = tabBarItem.badgeValue.intValue;
    num ++;
    [tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", num]];
}

- (void)reduceProductsNotification:(NSNotification *)notifi {
    
    UITabBarItem *tabBarItem = [[[self.tabBarController tabBar] items] objectAtIndex:2];
    num = tabBarItem.badgeValue.intValue;
    num --;
    [tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", num]];
    if (num <= 0) {
        tabBarItem.badgeValue = nil;
    }
}

#pragma mark - 移除通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 布局界面
- (void)setupUI {
    //监听增加产品通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(increaseProductsNotification:) name:@"increaseProducts" object:nil];
    
    //监听减少产品通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reduceProductsNotification:) name:@"reduceProducts" object:nil];
    
    UILabel *lbl = [UILabel bee_labelWithText:nil andColor:[UIColor blackColor] andFontSize:14.0f];
    [lbl sizeToFit];
    lbl.center = self.view.center;
    [self.view addSubview:lbl];
    
    //1、左侧的分类列表视图
    UITableView *tvCatogary = [[UITableView alloc] init];
    tvCatogary.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tvCatogary];
    
    [tvCatogary mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.equalTo(self.view);
        make.width.mas_equalTo(90);
        make.bottom.equalTo(self.view).offset(-44);
        
    }];
    
    //2、右侧的产品列表视图
    UITableView *tvProducts = [[UITableView alloc] init];
    tvProducts.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tvProducts];
    
    [tvProducts mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.right.equalTo(self.view);
        make.left.equalTo(tvCatogary.mas_right);
        make.bottom.equalTo(tvCatogary.mas_bottom);
        
    }];
    
    //MARK: -----设置列表属性-----
    //1、 设置数据源和代理对象
    tvCatogary.dataSource = self;
    tvCatogary.delegate = self;
    
    tvProducts.dataSource = self;
    tvProducts.delegate = self;
    
    //2、 注册
    [tvCatogary registerClass:[YQ_CategoryCell class] forCellReuseIdentifier:CategoryCellID];
    [tvProducts registerNib:[UINib nibWithNibName:@"YQ_Products" bundle:nil] forCellReuseIdentifier:ProductsCellID];
    
    // 注册header，负责注册tableView的组标题视图的
    // 继承自UITaleViewHeaderFooterView
    [tvProducts registerClass:[YQ_ProductsHeaderView class] forHeaderFooterViewReuseIdentifier:headerID];
    
    //3、隐藏指示条
    tvCatogary.showsVerticalScrollIndicator = NO;
    tvCatogary.showsHorizontalScrollIndicator = NO;
    
    //4、不显示多余的行
    tvCatogary.tableFooterView = [[UIView alloc] init];
    tvProducts.tableFooterView = [[UIView alloc] init];
    
    //5、设置分类列表的行高
    tvCatogary.rowHeight = 55;
    tvProducts.rowHeight = 90;
    
    //6、一定要设置这个属性,才会调用对应的代理方法
    tvProducts.sectionHeaderHeight = 23;
    
    //7、记录成员变量
    self.tvCategory = tvCatogary;
    self.tvProducts = tvProducts;
    
    //8、让分类列表,选中第一行!
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    [_tvCategory selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - 视图将要消失时移除网络加载图标
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [BeeSVProgressHUD dismiss];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"postProductsModel" object:_carList];
}

@end


