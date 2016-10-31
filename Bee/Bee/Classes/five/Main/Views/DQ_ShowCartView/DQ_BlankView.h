//
//  DQ_BlankView.h
//  Bee
//
//  Created by Apple on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DQ_BlankViewDelegate<NSObject>

-(void)goToHomeViewController;

@end

@interface DQ_BlankView : UIView

@property(weak,nonatomic)id<DQ_BlankViewDelegate>delegate;

@end
