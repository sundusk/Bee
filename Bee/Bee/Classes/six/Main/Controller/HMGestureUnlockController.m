//
//  HMGestureUnlockController.m
//  HMDeliver
//
//  Created by HaoYoson on 16/3/21.
//  Copyright © 2016年 YosonHao. All rights reserved.
//

#import "HMGestureUnlockController.h"
#import "HMGestureUnlockView.h"
#import "SVProgressHUD.h"
#import "UIView+Frame.h"
#import "YS_TabbarVC.h"
typedef enum : NSUInteger {
    HMGestureUnlockTypePasswordEnter,
    HMGestureUnlockTypePasswordSet,
    HMGestureUnlockTypePasswordRepeat,
} HMGestureUnlockType;

@interface HMGestureUnlockController ()

@property (weak, nonatomic) HMGestureUnlockView *pwdView;
@property (weak, nonatomic) UILabel *hintLabel;

@property (copy, nonatomic) NSString *tempPwd;

@property (assign, nonatomic) HMGestureUnlockType gestureUnlockType;

@end

@implementation HMGestureUnlockController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    if (self.navigationController) {
        // barView
        UIImageView *barView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
        barView.image = [UIImage imageNamed:@"bg_navigationBar_white"];
        [self.view addSubview:barView];
    }

    // 设置背景图片
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Home_refresh_bg"]];

    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"GestureUnlockPassword"]) {
        // 默认设置密码
        self.gestureUnlockType = HMGestureUnlockTypePasswordSet;
    }
    else {
        // 有密码 输入旧密码
        self.gestureUnlockType = HMGestureUnlockTypePasswordEnter;
    }

    // 创建pwdview
    HMGestureUnlockView *pwdView = [[HMGestureUnlockView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    

    
    
    
    pwdView.center = self.view.center;
    [self.view addSubview:pwdView];
    self.pwdView = pwdView;

    __weak HMGestureUnlockController *weakSelf = self;
    self.pwdView.pwdBlock = ^(NSString *pwd, UIImage *img) {
        NSLog(@"%@-----", pwd);

        // 如果当前是设置 那么保存并且进入重复设置
        if (weakSelf.gestureUnlockType == HMGestureUnlockTypePasswordSet) {
            weakSelf.tempPwd = pwd;
            weakSelf.gestureUnlockType = HMGestureUnlockTypePasswordRepeat;
        }
        else if (weakSelf.gestureUnlockType == HMGestureUnlockTypePasswordRepeat) {
            if ([pwd isEqualToString:weakSelf.tempPwd]) {
                // 保存密码
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud setObject:pwd forKey:@"GestureUnlockPassword"];
                [ud synchronize];

                [SVProgressHUD showSuccessWithStatus:@"设置成功"];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
            else {
                [SVProgressHUD showErrorWithStatus:@"您输入的密码不一致 请重新输入"];
                weakSelf.gestureUnlockType = HMGestureUnlockTypePasswordSet;
                return NO;
            }
        }
        else if (weakSelf.gestureUnlockType == HMGestureUnlockTypePasswordEnter) {
            if ([pwd isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"GestureUnlockPassword"]]) {

                if (weakSelf == [UIApplication sharedApplication].keyWindow.rootViewController) {
                    // 如果是根控制器 也就是进程序输入的密码 那么显示tabbar
                    [UIApplication sharedApplication].keyWindow.rootViewController = [[YS_TabbarVC alloc] init];
                }
                else {
                    weakSelf.gestureUnlockType = HMGestureUnlockTypePasswordSet;
                }
            }
            else {
                // 密码错误
                [SVProgressHUD showErrorWithStatus:@"密码错误 请重新输入"];
                return NO;
            }
        }

        return YES;
    };
}

- (void)setGestureUnlockType:(HMGestureUnlockType)gestureUnlockType
{
    _gestureUnlockType = gestureUnlockType;

    if (!_hintLabel) {
        // 文字提示label
        UILabel *hintLabel = [[UILabel alloc] init];
        hintLabel.frame = CGRectMake(0, 100, kScreenWidth, 30);
        hintLabel.textAlignment = NSTextAlignmentCenter;
        hintLabel.textColor = [UIColor whiteColor];
        [self.view addSubview:hintLabel];

        self.hintLabel = hintLabel;
        
        
       
        
    }

    switch (self.gestureUnlockType) {
    case HMGestureUnlockTypePasswordEnter:
        self.hintLabel.text = @"请输入密码";
            
        break;
    case HMGestureUnlockTypePasswordSet:
        self.hintLabel.text = @"请设置新密码";
            
        {
            UIButton *btn = [UIButton bee_buttonWithTitle:@"清空手势密码" andFontSize:14 andNormalColor:[UIColor orangeColor] andSelectedColor:[UIColor redColor]];
            
            [self.view addSubview:btn];
            
            [btn addTarget:self action:@selector(longPressGesture) forControlEvents:UIControlEventTouchUpInside];
            
            //        [btn sizeToFit];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.right.equalTo(self.view);
                make.bottom.equalTo(self.hintLabel.mas_top).offset(-30);
                
            }];
        }
      
        break;
        
    case HMGestureUnlockTypePasswordRepeat:
        self.hintLabel.text = @"清再次输入新密码";
        break;

    default:
        break;
    }
}
- (void)longPressGesture{
    
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    [ud removeObjectForKey:@"GestureUnlockPassword"];
    
    [ud synchronize];
    
    [SVProgressHUD showSuccessWithStatus:@"清除成功"];
    
    [self.navigationController popViewControllerAnimated:YES];

}
@end