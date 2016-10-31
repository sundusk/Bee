//
//  XW_HomeCollectionViewCell.m
//  Bee
//
//  Created by 9264 on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "XW_HomeCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation XW_HomeCollectionViewCell

- (void)setActivitiesModel:(XW_ActivitiesModel *)activitiesModel{
    _activitiesModel = activitiesModel;
    UIImageView *listImageVeiw = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
    [listImageVeiw sd_setImageWithURL:[NSURL URLWithString:activitiesModel.img] placeholderImage:[UIImage imageNamed:@"L1"]];
    [self.contentView addSubview:listImageVeiw];

}
@end
