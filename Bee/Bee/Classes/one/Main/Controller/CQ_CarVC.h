//
//  CCQMainVC.h
//  NBApp
//
//  Created by yaoshuai on 16/9/6.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XW_FreshModel.h"

@interface CQ_CarVC : UIViewController

/**
 *  接受传过来的数组
 */
@property (strong , nonatomic) NSMutableArray<XW_FreshModel *> *commodity;

/**
 *  接受传过来的总计
 */
@property(assign,nonatomic) float allNum;


@end
