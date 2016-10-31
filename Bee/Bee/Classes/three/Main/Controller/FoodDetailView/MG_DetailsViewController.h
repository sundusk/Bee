//
//  MG_DetailsViewController.h
//  Bee
//
//  Created by apple on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XW_FreshModel.h"
#import "XW_FreshModel.h"
@class YQ_CategoryModel;
@protocol MG_DetailsViewControllerdelegate <NSObject>

@optional
- (void)shopCarCount:(NSInteger)count;

@end
@interface MG_DetailsViewController : UIViewController
@property(weak,nonatomic) id<MG_DetailsViewControllerdelegate> delegate;

/**
 *  负责接收已经选中的菜品信心
 */
@property (strong, nonatomic) XW_FreshModel *productsModel;
@property (strong, nonatomic) XW_FreshModel *freshModel;
@end
