//
//  CQ_SearchHistoryAndHotView.m
//  CCQ_Demo
//
//  Created by 神威 on 16/9/11.
//  Copyright © 2016年 ccq. All rights reserved.
//

#import "CQ_SearchHistoryAndHotView.h"
#import "CQ_SHFlowLayout.h"
#import "CQ_SearchHistoryCollectionCell.h"
#import "CQ_SearchHistoryModel.h"
#define SCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define SectionHeaderFooterWH 35
static CGFloat const margin = 10;

static NSString *const itemCollectionIdentifier =  @"itemCollection";
static NSString *const headerCollectionIdentifier = @"headerCollection";
static NSString *const footerCollectionIdentifier = @"footerCollection";
@interface CQ_SearchHistoryAndHotView() <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (nonatomic, strong)  CQ_SearchHistoryCollectionCell*cell;


@end
@implementation CQ_SearchHistoryAndHotView{
        CQ_SHFlowLayout *_layout;
        NSMutableArray *_hotArray;//热门数组
        NSMutableArray *_historyArray;//历史数组
}
- (instancetype)initWithFrame:(CGRect)frame {
    self =  [super initWithFrame:frame];
    if (self) {
        self.scrollEnabled = YES;
        self.contentSize = CGSizeMake(SCREENWIDTH, self.bounds.size.height +30);
        self.delegate = self;
        [self addAllData];
        [self setupCollectionView];
    }
    return self;
}

#pragma mark - 数组存储热门搜索和历史记录的字符串

- (void)addAllData {
    
    _hotArray = [NSMutableArray arrayWithArray:[NSArray arrayWithObjects:@"月饼",@"酸奶",@"水",@"车厘子",@"洽洽瓜子",@"维他",@"香烟",@"周黑鸭",@"草莓",@"卤味",nil]];
    
    _historyArray = [[CQ_SearchHistoryModel shareInstance] getSearchHistoryMArray];
  
}

#pragma mark - 设置layout和collectionView

- (void)setupCollectionView {
    
    _layout = [[CQ_SHFlowLayout alloc]init];
    _layout.minimumInteritemSpacing = margin;
    _layout.minimumLineSpacing = margin;
    _layout.headerReferenceSize = CGSizeMake(SCREENWIDTH, SectionHeaderFooterWH);
    _layout.footerReferenceSize = CGSizeMake(SCREENWIDTH, SectionHeaderFooterWH);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:_layout];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
    _collectionView.scrollEnabled = YES;
    _collectionView.backgroundColor = DefaultColor;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self addSubview:_collectionView];
    [self registerIdentifier];
}


#pragma mark - 注册标识符

- (void)registerIdentifier {
    [_collectionView registerClass:[CQ_SearchHistoryCollectionCell class] forCellWithReuseIdentifier:itemCollectionIdentifier];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCollectionIdentifier];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerCollectionIdentifier];
    
}

#pragma mark -- collection数据源代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

//判断cell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return _hotArray.count;
    }else{
        if (_historyArray.count >10) {
            return 10;
        } else return _historyArray.count;
    }
}

//判断每个组实现每个cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CQ_SearchHistoryCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemCollectionIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    if (indexPath.section == 0) {
        cell.titleLabel.text = _hotArray[indexPath.item];
        
    } else {
        cell.titleLabel.text = _historyArray[indexPath.item];
    }
    return cell;
}



- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsMake(15, margin, -10, margin);
    } return UIEdgeInsetsMake(15, margin, 15,margin);
}

#pragma mark - 布局热门搜索和历史记录

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionHeader) { //头部视图
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerCollectionIdentifier forIndexPath:indexPath];
        if (indexPath.section == 0) {
            //               添加背景视图的父视图
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(-10, 0, headerView.bounds.size.width+10, SectionHeaderFooterWH)];
          
            [headerView addSubview:backView];
            
            //    添加头部标题
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREENWIDTH/2, SectionHeaderFooterWH)];
            label.text = @"热门搜索";
            label.textColor = [UIColor grayColor];
            [backView addSubview:label];
        } else {
            UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(-10, 0, headerView.bounds.size.width, SectionHeaderFooterWH)];
           
            [headerView addSubview:backgroundView];
            //   新增头部标题
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, headerView.bounds.size.width, 30)];
            label.text = @"历史搜索";
            label.textColor = [UIColor grayColor];
            [backgroundView addSubview:label];
            
        }
        return headerView;
    } else { //脚部视图
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerCollectionIdentifier forIndexPath:indexPath];
        if (indexPath.section == 1 && _historyArray.count != 0) {
            
//            footerView.backgroundColor = [UIColor redColor];
            UIView *fGreenView = [[UIView alloc]init];
//            fGreenView.backgroundColor = [UIColor greenColor];
            [footerView addSubview:fGreenView];
            
            [fGreenView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(footerView);
                make.centerY.equalTo(footerView);
                make.width.equalTo(@100);
                make.height.equalTo(@SectionHeaderFooterWH);
            }];
            UIButton *bth = [[UIButton alloc]init];
            
            bth.backgroundColor = [UIColor whiteColor];
            
            [bth.layer setMasksToBounds:YES];
            [bth.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
            //边框宽度
            [bth.layer setBorderWidth:1.0];
            bth.layer.borderColor=[UIColor grayColor].CGColor;
            [bth setTitle:@"清空记录" forState:UIControlStateNormal];
            [bth setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [bth addTarget:self action:@selector(clearBtn:) forControlEvents:UIControlEventTouchUpInside ];
            [fGreenView addSubview:bth];
            
            [bth mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(fGreenView);
                make.centerY.equalTo(fGreenView);
                make.width.equalTo(@200);
            }];

            return footerView;
        }else{
             footerView.frame = CGRectZero;
            return footerView;
        }
        
        
    }
    
}
#pragma mark - 清空历史记录

- (void)clearBtn:(UIButton *)btn {
    //   清除存储的数据源
    [[CQ_SearchHistoryModel shareInstance] clearAllSearchHistory];
    [[CQ_SearchHistoryModel shareInstance] saveSearchItemHistory];
    
    [_historyArray removeAllObjects];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
    });
}

//根据文字大小计算不同item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeZero;
    if (indexPath.section == 0) {
        size  = [_hotArray[indexPath.item] sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]}];
        
    }else {
        size  = [_historyArray[indexPath.item] sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]}];
        
    }
    return  CGSizeMake(size.width+35, 35);
}

#pragma mark - 点击item的方法

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
      
        if (self.searchHotAndHistoryDelegate && [self.searchHotAndHistoryDelegate respondsToSelector:@selector(searchItemClickHotItem: collectionItem:)]) {
            [_searchHotAndHistoryDelegate searchItemClickHotItem:_hotArray[indexPath.item] collectionItem:ClickCollectionItemHot];
        }
    } else {
        //        NSLog(@"点击搜索历史:%@",_newHistoryArray[indexPath.item]);
        if (self.searchHotAndHistoryDelegate && [self.searchHotAndHistoryDelegate respondsToSelector:@selector(searchItemClickHotItem:collectionItem:)]) {
            NSLog(@"%@",_historyArray);
            
            [_searchHotAndHistoryDelegate searchItemClickHotItem:_historyArray[indexPath.item] collectionItem:ClickCollectionItemHistory];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.searchHotAndHistoryDelegate && [self.searchHotAndHistoryDelegate respondsToSelector:@selector(searchBarResignWhenScroll)]) {
        [self.searchHotAndHistoryDelegate searchBarResignWhenScroll];
    }
}



@end
