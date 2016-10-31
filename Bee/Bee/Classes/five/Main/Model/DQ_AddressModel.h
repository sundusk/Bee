//
//  DQ_AddressModel.h
//  Bee
//
//  Created by Apple on 16/9/10.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DQ_AddressModel : NSObject

//联系人
@property(copy,nonatomic) NSString *name;
//性别属性
@property(copy,nonatomic) NSString *isMale;
//手机号
@property(copy,nonatomic) NSString *phoneNum;
//城市
@property(copy,nonatomic) NSString *city;
//地址
@property(copy,nonatomic) NSString *address;
//门票号
@property(copy,nonatomic) NSString *houseNum;
//保存cell所在的行数
@property(strong,nonatomic)NSIndexPath *indexpath;
//保持cellID
@property(copy,nonatomic)NSString *cellID;

@end
