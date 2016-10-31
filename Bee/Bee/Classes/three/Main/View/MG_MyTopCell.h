//
//  MG_MyTopCell.h
//  Bee
//
//  Created by yaoshuai on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MG_MyTopCellDelegate <NSObject>

- (void)topCellJumpToVC:(NSString *)vcName;

@end

@interface MG_MyTopCell : UITableViewCell

@property (weak, nonatomic) id<MG_MyTopCellDelegate> delegate;

@end
