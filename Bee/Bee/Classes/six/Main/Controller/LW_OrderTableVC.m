//
//  LW_OrderTableVC.m
//  Bee
//
//  Created by huanglinwang on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "LW_OrderTableVC.h"
#import "LW_OrderCell.h"
#import "DSHTTPClient.h"
#import "LW_OrderModel.h"
#import "YS_OrderStatusVC.h"

@interface LW_OrderTableVC ()<UITabBarDelegate,UITableViewDataSource>

@end

@implementation LW_OrderTableVC{
    //总数据
    NSArray<LW_OrderModel *> *_dataList;
    //临时图片数组
    NSMutableArray<UIImage *> *_imageList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageList = [NSMutableArray array];
    
//    self.navigationController.navigationBar.tintColor = [UIColor redColor];
//    self.navigationItem.title = @"我的订单";
//    self.navigationController.navigationBar.backgroundColor = [UIColor lightGrayColor];
    [self loadData];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LW_OrderCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}

#pragma mark - 加载数据
-(void)loadData{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setValue:@"13" forKey:@"call"];
    
    
    [DSHTTPClient postUrlString:@"http://iosapi.itcast.cn/loveBeen/MyOrders.json.php" withParam:param withSuccessBlock:^(id data) {
//        NSLog(@"%@",data);
        
        NSArray *dataArr = data[@"data"];
        NSMutableArray *arrayM = [NSMutableArray array];
        [dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            LW_OrderModel *model = [LW_OrderModel lw_OrderModel:obj];
//            NSLog(@"%@",model);
            [arrayM addObject:model];
        }];
        
        _dataList = arrayM.copy;
        
        [self.tableView reloadData];
        
        
    } withFailedBlock:^(NSError *error) {
        NSLog(@"%@",error);
    } withErrorBlock:^(NSString *message) {
        NSLog(@"%@",message);
    }];
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    LW_OrderCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    LW_OrderModel *model = _dataList[indexPath.row];
    
    cell.model = model;

    return cell;
}
#pragma mark - 设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 145;
}
#pragma mark - 选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",@(indexPath.row).description);
    
    YS_OrderStatusVC *ys_OrderStatusVC = [[YS_OrderStatusVC alloc]init];
    
    
    ys_OrderStatusVC.dictArray = _dataList[indexPath.row].status_timeline;
    
    NSLog(@"%@",ys_OrderStatusVC.dictArray);
    
    [self.navigationController pushViewController:ys_OrderStatusVC animated:YES];
    
    
}


@end
