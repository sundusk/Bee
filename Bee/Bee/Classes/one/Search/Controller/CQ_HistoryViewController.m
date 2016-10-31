//
//  CQ_HistoryViewController.m
//  CCQ_Demo
//
//  Created by 神威 on 16/9/11.
//  Copyright © 2016年 ccq. All rights reserved.
//

#import "CQ_HistoryViewController.h"
#import "CQ_SeaSaleSearchBarView.h"
#import "CQ_SearchHistoryAndHotView.h"
#import "CQ_SearchHistoryModel.h"
#import "CQ_NextViewController.h"
#import "BeeSVProgressHUD.h"

#define SCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define DefaultColor [UIColor colorWithWhite:0.95 alpha:1.0]
static NSString *const cellIdentifier = @"cellIdentifierKey";


@interface CQ_HistoryViewController ()<UITextFieldDelegate,SearchBarViewDelegate,UITableViewDataSource,UITableViewDelegate,CQ_SearchItemDelegate>


@end

@implementation CQ_HistoryViewController{
    NSArray *_dataArray;//总的数据数组
    NSMutableArray *_searchArray;//输入搜索关键字检索得到的内容数组，在dataArray
    NSMutableArray *_historyArray;//历史数组
    UITableView *_tabeleView;
    CQ_SeaSaleSearchBarView *search;
    CQ_SearchHistoryAndHotView *historyAndHotView;//搜索的View
}



- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //移除历史记录
    if (historyAndHotView) {
        [historyAndHotView removeFromSuperview];
    }
    [self addSearchContentView];//添加搜索内容（热门和历史）视图
    [search.searchBar becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [search endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DefaultColor;
    self.view.backgroundColor = DefaultColor;
    [self initData];//初始化数据
    [self initNavigationBarSearchBar];//初始化导航条内容
    [self creatTable];//创建搜索历史的tableview
}

//加载数据源
- (void)initData {
    //    总的数据源，检索库
//    _dataArray = @[@"水",@"",@"我就是我",@"是的",@"颜色不一样的烟花",@"我的生活没有自然和社会"];
//    _searchArray = [[NSMutableArray alloc] init];
    _historyArray = [[CQ_SearchHistoryModel shareInstance] getSearchHistoryMArray];
}

- (void)initNavigationBarSearchBar {
    search = [[CQ_SeaSaleSearchBarView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH*2/3, 30) placeHolder:@"输入想要搜索的商品" Delegate:self];
    search.layer.masksToBounds =YES;
    search.layer.cornerRadius = 10;
    search.searchBar.returnKeyType = UIReturnKeySearch;
    search.searchBar.keyboardType = UIKeyboardTypeDefault;
    self.navigationItem.titleView = search;
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(popVC)];
    btn.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = btn;
}

//实现点击跳转
- (void)popVC {
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)addSearchContentView {
    
    historyAndHotView = [[CQ_SearchHistoryAndHotView alloc]initWithFrame: CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-64)];
    historyAndHotView.searchHotAndHistoryDelegate = self;
    [self.view addSubview:historyAndHotView];
    
}
#pragma mark - tableview

- (void)creatTable {
    //创建tableView
    _tabeleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64) style:UITableViewStylePlain];
    
    _tabeleView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _tabeleView.hidden = YES;
    _tabeleView.rowHeight = 45;
    _tabeleView.delegate = self;
    _tabeleView.dataSource = self;
    [_tabeleView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:_tabeleView];
}

#pragma mark   tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _searchArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = _searchArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
 
    [self saveHistoryAdjustLocation:cell.textLabel.text];
    
    [self jumpToSearchResult:cell.textLabel.text];
}

//保存最新搜索的内容到本地数组的第0位

- (void)saveHistoryAdjustLocation:(NSString *)searchText {
    //   加入进历史搜索数组中
    [_historyArray containsObject:searchText] ? ([_historyArray removeObject:searchText]) : nil;
    [_historyArray insertObject:searchText atIndex:0];
    //    保存该新增的字符串到本地
    [[CQ_SearchHistoryModel shareInstance] saveSearchItemHistory];
}
#pragma  mark 搜索的代理方法
/**
 搜索框搜索按钮点击事件：点击搜索
 */
- (void)searchBarFieldButtonClicked:(UISearchBar *)searchBar {
    [self saveHistoryAdjustLocation:searchBar.text];
    //   跳转方法
    [self jumpToSearchResult:searchBar.text];
}

/**
 搜索框更新编辑
 */
- (void)searchBarFieldChangeEditing:(NSString *)searchText {
    if ([searchText isEqualToString:@""]) {//输入为空
        _tabeleView.hidden = YES;
    } else
        _tabeleView.hidden = NO;
    [self searchDataWithKeyWord:searchText];
}

//搜索的方法：将数据源内搜索的数据加到加载到搜索数组内
- (void)searchDataWithKeyWord:(NSString *)keyWord {
    
    [_dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *tempString = obj;
        if ([tempString containsString:keyWord]||[tempString containsString:@"我"]) {
            NSMutableArray *tempArray = [[NSMutableArray alloc]init];
            [tempArray  addObject:tempString];
            for (unsigned i = 0 ; i< [tempArray count]; ++i) {
                if (![_searchArray containsObject:tempArray[i]]) {
                    [_searchArray addObject:tempArray[i]];
                }
            }
        }
    }];
    [_tabeleView reloadData];//刷新表格
}

#pragma  mark  热门和历史搜索的Delegate方法
- (void)searchItemClickHotItem:(NSString *)itemName collectionItem:(ClickCollectionItem)collectionItem {
    if (collectionItem == ClickCollectionItemHot) {//若点击的是热门
        NSLog(@"点击热门:%@",itemName);
    } else {//搜索历史记录
        //  调整单利数组中位置
        [self saveHistoryAdjustLocation:itemName];
        NSLog(@"点击搜索历史:%@",itemName);
    }
    [self jumpToSearchResult:itemName];
}

#pragma mark  新增搜索结果的界面数据
- (void)jumpToSearchResult:(NSString *)goodsName {
    
    [BeeSVProgressHUD showWithStatus:@"正在全力搜索"];


    [self performSelector:@selector(dismiss) withObject:nil afterDelay:1];
    
}
//跳转
- (void)dismiss{
    
    [BeeSVProgressHUD dismiss];
    
    CQ_NextViewController *searchVC = [[CQ_NextViewController alloc] init];
    //    传递搜索内容给下一级别界面作为参数
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
}
- (void)searchBarResignWhenScroll {
    [search endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
