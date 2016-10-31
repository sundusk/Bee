//
//  XW_HomeFlowLayout.m
//  Bee
//
//  Created by 9264 on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "XW_HomeFlowLayout.h"

@implementation XW_HomeFlowLayout
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupLayout];
    }
    return self;
}
- (void)setupLayout{
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
}
- (void)prepareLayout {
    [super prepareLayout];
    self.itemSize = CGSizeMake(self.collectionView.bounds.size.width, 100);
}


@end
