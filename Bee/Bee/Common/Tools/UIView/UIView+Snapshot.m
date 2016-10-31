//
//  UIView+Snapshot.m
//  工具包-OC
//
//  Created by yaoshuai on 16/8/13.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "UIView+Snapshot.h"

@implementation UIView (Snapshot)

#pragma mark - 屏幕快照
- (UIImage *)bee_snapshotImage
{
    //开启图片的图形上下文
    //参数1：图片上下文的大小
    //参数2：不透明(YES：不透明；NO：透明)
    //参数3：缩放因子，即2X、3X，设为0.0，系统会自动识别
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);
    
    //将当前视图的层次结构渲染到上下文中
    //updates -> 是否更新? -> tableView在滚动的过程,截图!保证不会有不清晰的情况
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    //获取图片
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    //返回图片
    return snapshotImage;
    
    //保存到相册
    //UIImageWriteToSavedPhotosAlbum(snapshotImage, nil, nil, nil);
}

@end
