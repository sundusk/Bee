//
//  XW_ClassificationView.h
//  Bee
//
//  Created by 9264 on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum NSUInteger{
    kButtonScan = 1,
    kButtonCard = 2,
    kButtonPay = 3,
    kButtonXiu = 4,
}ClassificationButton;
@class XW_IconsModel;
@protocol XW_IconsModellDelegate<NSObject>
@optional
- (void)jumpToVC:(UIButton *)sender;
@end
@interface XW_ClassificationView : UIView
@property (strong, nonatomic) NSArray<XW_IconsModel *> *iconsModelArray;
@property (weak, nonatomic) id<XW_IconsModellDelegate> delegate;
@end
