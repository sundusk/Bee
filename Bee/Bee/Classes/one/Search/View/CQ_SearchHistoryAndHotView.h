//
//  CQ_SearchHistoryAndHotView.h
//  CCQ_Demo
//
//  Created by 神威 on 16/9/11.
//  Copyright © 2016年 ccq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQ_SearchItemDelegate.h"
@interface CQ_SearchHistoryAndHotView : UIScrollView
//定义代理
@property (nonatomic, weak) id<CQ_SearchItemDelegate> searchHotAndHistoryDelegate;
//定义collectionView
@property (nonatomic, strong) UICollectionView *collectionView;

@end
