//
//  CQ_SearchHistoryModel.h
//  CCQ_Demo
//
//  Created by 神威 on 16/9/11.
//  Copyright © 2016年 ccq. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  搜索历史记录管理，这个保存在本地
 */
@interface CQ_SearchHistoryModel : NSObject


+(CQ_SearchHistoryModel*)shareInstance;

/**
 *  获取历史搜索记录
 *
 */
-(NSMutableArray*)getSearchHistoryMArray;

/**
 *  清空搜索记录
 */
-(void)clearAllSearchHistory;


/*
 * 保存搜索历史到文件
 */
- (void)saveSearchItemHistory;
@end
