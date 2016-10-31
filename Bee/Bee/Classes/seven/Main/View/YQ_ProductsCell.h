//
//  YQ_ProductsCell.h
//  Bee
//
//  Created by 黄跃奇 on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XW_FreshModel,YQ_ProductsCell;

//MARK: - 1. 制定协议
@protocol YQ_ProductsCellDelegate <NSObject>

@optional
/**
 *  cell里面要增加的产品
 *  要有产品,还需要起始点!
 */
- (void)productsCell:(YQ_ProductsCell *)productsCell didFinishIncreseProducts:(XW_FreshModel *)productsModel andStartPoint:(CGPoint)startPoint animImageView:(UIImageView *)animImageView;

/**
 *  cell里面减少的产品
 */
- (void)productsCell:(YQ_ProductsCell *)productsCell didFinishReduceProducts:(XW_FreshModel *)productsModel;

@end

@interface YQ_ProductsCell : UITableViewCell

@property(strong, nonatomic) XW_FreshModel *productsModel;

//MARK: - 2. 设置代理属性
@property(weak, nonatomic) id<YQ_ProductsCellDelegate> delegate;





@end
