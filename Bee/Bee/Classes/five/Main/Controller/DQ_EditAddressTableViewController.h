//
//  DQ_EditAddressTableViewController.h
//  Bee
//
//  Created by Apple on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DQ_AddressModel.h"

@interface DQ_EditAddressTableViewController : UITableViewController
//给出判断是新增地址还是编辑地址的外界入口
@property(assign,nonatomic)NSInteger entranceId;
//接收cell所在的模型数据
@property(strong,nonatomic)DQ_AddressModel *model;
@end
