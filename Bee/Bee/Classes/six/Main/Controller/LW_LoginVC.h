//
//  LW_LoginVC.h
//  Bee
//
//  Created by huanglinwang on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YS_TabbarVC.h"
@class YS_TabbarVC;
@interface LW_LoginVC : UIViewController


@property(nonatomic,strong)void (^ block)();

+(NSString *)phoneNum;

@end
