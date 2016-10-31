//
//  XW_FreshCollectionViewCell.h
//  Bee
//
//  Created by 9264 on 16/9/9.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XW_FreshModel.h"
@interface XW_FreshCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong) XW_FreshModel *freshModel;
//数量
@property (assign, nonatomic) NSInteger count;
//增加还是减少
@property (assign, nonatomic) BOOL isIncrease;
//动画的起始点
@property (assign, nonatomic) CGPoint startP;
@end
