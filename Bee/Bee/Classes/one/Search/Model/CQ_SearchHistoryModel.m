//
//  CQ_SearchHistoryModel.m
//  CCQ_Demo
//
//  Created by 神威 on 16/9/11.
//  Copyright © 2016年 ccq. All rights reserved.
//

#import "CQ_SearchHistoryModel.h"
/// 历史记录保存路径
#define ASETTING_SEARCH_ITEM_FILE_NAME @"/searchItemHistory.txt"

@interface CQ_SearchHistoryModel ()

/**
 *  搜索历史
 */
@property (nonatomic, strong) NSMutableArray *searchHistoryMArray;

@end

@implementation CQ_SearchHistoryModel

+ (CQ_SearchHistoryModel*)shareInstance {
    static CQ_SearchHistoryModel *searchHistory = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!searchHistory) {
            searchHistory = [[CQ_SearchHistoryModel alloc] init];
        }
    });
    
    return searchHistory;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [filePath lastObject];
        NSString *searchPath = [path stringByAppendingPathComponent:ASETTING_SEARCH_ITEM_FILE_NAME];
        NSArray *fileArray = [NSMutableArray arrayWithContentsOfFile:searchPath];
        NSLog(@"打印路径：%@",searchPath);
        for (NSString *d in fileArray) {
            if (nil !=d) {
                [self.searchHistoryMArray addObject:d];
            }
        }
        
    }
    return self;
}
//获取单利的数组
-(NSMutableArray*) getSearchHistoryMArray {
    return [CQ_SearchHistoryModel shareInstance].searchHistoryMArray;
}

//清除搜索记录
-(void)clearAllSearchHistory {
    [[CQ_SearchHistoryModel shareInstance].searchHistoryMArray removeAllObjects];
}

// 保存历史记录
- (void)saveSearchItemHistory
{
    //    仅仅保存记录10个历史记录
    if ([self.searchHistoryMArray count]>10) {
        [_searchHistoryMArray removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(10, _searchHistoryMArray.count-10)]];
    }
    
 
    NSMutableArray *fileArray = [[NSMutableArray alloc] init];
    for (NSString  *d in _searchHistoryMArray) {
        [fileArray addObject:d];
    }
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    path = [path stringByAppendingPathComponent:ASETTING_SEARCH_ITEM_FILE_NAME];
    [fileArray writeToFile:path atomically:YES];
}

#pragma mark =====getter 方法：获取该可变数组
-(NSMutableArray *)searchHistoryMArray{
    if (!_searchHistoryMArray) {
        _searchHistoryMArray = [[NSMutableArray alloc]init];
    }
    return _searchHistoryMArray;
}

@end
