//
//  CQ_SHFlowLayout.m
//  CCQ_Demo
//
//  Created by 神威 on 16/9/11.
//  Copyright © 2016年 ccq. All rights reserved.
//

#import "CQ_SHFlowLayout.h"

@implementation CQ_SHFlowLayout

//设置item位置
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray * originalArray = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *superAttributes =[[NSMutableArray alloc] initWithArray:originalArray copyItems:YES];
    
    NSMutableDictionary *rowCollections = [NSMutableDictionary new];//创建字典存储所有item的布局
    
   
    for (UICollectionViewLayoutAttributes *itemAttributes in superAttributes)//遍历item获得每个item的布局,将布局加入数组itemAttributes
    {
        NSNumber *yCenter = @(CGRectGetMidY(itemAttributes.frame));//获取每个item的最小Y值
        
        if (!rowCollections[yCenter])
            rowCollections[yCenter] = [NSMutableArray new];//将每个item最小Y值作为数组写成字典
        
        [rowCollections[yCenter] addObject:itemAttributes];//将每个item布局数组加入字典Value中
    }
    
   
    [rowCollections enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {//遍历布局字典,obj是每个item的布局
        
        NSArray *itemAttributesCollection = obj;
        
        //   行中所有元素的宽度
        CGFloat aggregateItemWidths = 0.f;
        for (UICollectionViewLayoutAttributes *itemAttributes in itemAttributesCollection)
            aggregateItemWidths += CGRectGetWidth(itemAttributes.frame);
        
        CGFloat alignmentXOffset = 10;//每行item的x
        
        //   定义item的位置,排列好item
        CGRect previousFrame = CGRectZero;
        for (UICollectionViewLayoutAttributes *itemAttributes in itemAttributesCollection)
        {
            CGRect itemFrame = itemAttributes.frame;
            
            if (CGRectEqualToRect(previousFrame, CGRectZero))//如果CGRect为空
                itemFrame.origin.x = alignmentXOffset;//item的x为首行x
            else
                itemFrame.origin.x = CGRectGetMaxX(previousFrame) + self.minimumInteritemSpacing;//否则就是item的右边x+间隔
            
            itemAttributes.frame = itemFrame;
            previousFrame = itemFrame;
        }
    }];
    
    return superAttributes;
}
@end
