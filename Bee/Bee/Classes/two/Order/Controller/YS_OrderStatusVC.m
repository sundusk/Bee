//
//  YS_OrderStatusVC.m
//  Bee
//
//  Created by yaoshuai on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "YS_OrderStatusVC.h"
#import "YS_OrderStatusCell.h"
#import "YS_OrderStatusModel.h"

#define orderStatusCellID @"orderStatusCellID"

@interface YS_OrderStatusVC ()
{
    NSArray<NSDictionary *> *_statusArray;
}
@end

@implementation YS_OrderStatusVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.estimatedRowHeight = 70;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[YS_OrderStatusCell class] forCellReuseIdentifier:orderStatusCellID];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _statusArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YS_OrderStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:orderStatusCellID forIndexPath:indexPath];
    
    NSDictionary *dict = _statusArray[indexPath.row];
    YS_OrderStatusModel *orderModel = [[YS_OrderStatusModel alloc] init];
    [orderModel setValuesForKeysWithDictionary:dict];
    
    cell.orderStatusModel = orderModel;
    return cell;
}

- (void)setDictArray:(NSArray<NSDictionary *> *)dictArray
{
    _dictArray = dictArray;
    NSMutableArray<NSDictionary *> *arrM = [NSMutableArray arrayWithCapacity:dictArray.count];
    NSString *timeKey = @"status_time";
    NSString *titleKey = @"status_title";
    NSString *descKey = @"status_desc";
    
    [dictArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *dict;
        if(idx == 0)
        {
            dict = @{@"time":obj[timeKey],@"title":obj[titleKey],@"subtitle":obj[descKey],@"selected":@"YES",@"idxType":@"1"};
        }
        else if(idx == dictArray.count - 1)
        {
            dict = @{@"time":obj[timeKey],@"title":obj[titleKey],@"subtitle":obj[descKey],@"selected":@"NO",@"idxType":@"1000"};
        }
        else
        {
            dict = @{@"time":obj[timeKey],@"title":obj[titleKey],@"subtitle":obj[descKey],@"selected":@"NO",@"idxType":@"2"};
        }
        [arrM addObject:dict];
    }];
    _statusArray = arrM.copy;
    [self.tableView reloadData];
}

@end
