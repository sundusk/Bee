//
//  HMGestureUnlockView.h
//  HMDeliver
//
//  Created by HaoYoson on 16/3/21.
//  Copyright © 2016年 YosonHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMGestureUnlockView : UIView

@property (copy, nonatomic) BOOL (^pwdBlock)(NSString *, UIImage *);

@end
