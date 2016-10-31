//
//  MG_DetailsTableViewCell.h
//  Bee
//
//  Created by apple on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XW_FreshModel.h"
#import "XW_FreshModel.h"

@interface MG_DetailsTableViewCell : UITableViewCell

+ (instancetype)detailsTableViewCell;
@property(strong,nonatomic) XW_FreshModel *YQModel;
@property(strong,nonatomic) XW_FreshModel *XWmodel;
@end
