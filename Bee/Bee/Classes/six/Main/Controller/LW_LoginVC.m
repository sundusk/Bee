//
//  LW_LoginVC.m
//  Bee
//
//  Created by huanglinwang on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "LW_LoginVC.h"
#import <SMS_SDK/SMSSDK.h>
#import "SVProgressHUD.h"
#import "HMGestureUnlockController.h"
#import "YS_TabbarVC.h"
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>


#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
@interface LW_LoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *smsRegisterBtn;

// 用于倒计时的数字
@property (nonatomic ,assign) NSInteger count;
// 创建一个NSTimer对象
@property (nonatomic ,strong) NSTimer *timer;

@end

@implementation LW_LoginVC


-(void)awakeFromNib{
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}
//开发人员测试专用
- (IBAction)develop:(UIButton *)sender {
    
    NSString *cachesDirPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"name.db"];
    
    
    [@"我是开发者" writeToFile:cachesDirPath atomically:YES
                                encoding:NSUTF8StringEncoding error:nil];
    
}


+(NSString *)phoneNum{
    
    NSString *cachesDirPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"name.db"];
    
    
    NSFileManager *manager =  [NSFileManager defaultManager];
    
    BOOL isDirectroy = [manager fileExistsAtPath:cachesDirPath];
    
//    NSLog(@"%d",isDirectroy);
    
    
    if (isDirectroy) {
        return [[NSString alloc]initWithData:[NSData dataWithContentsOfFile:cachesDirPath] encoding:NSUTF8StringEncoding];
    }else{
        return @"";
    
    }
}
- (IBAction)forgetPassword:(UIButton *)sender {
    
 
    [SVProgressHUD showErrorWithStatus:@"忘记密码怪谁呢 ^_^ !!"];
}
- (IBAction)goBackBtn:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    //跳转到首页 -通过block传值.
    self.block();
    
}

#pragma mark - 登陆
- (IBAction)loginBtn:(UIButton *)sender {
    
    [_nameTextField resignFirstResponder];
    [_passwordField resignFirstResponder];
    

    
    [SMSSDK commitVerificationCode:self.passwordField.text
                       phoneNumber:self.nameTextField.text
                              zone:@"86"
                            result:^(NSError *error) {
                                if (!error) {
                                    
                                    [SVProgressHUD showSuccessWithStatus:@"验证成功"];
                                    
                                        NSString *cachesDirPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"name.db"];
                                    
                                    
                                        [self.nameTextField.text writeToFile:cachesDirPath atomically:YES
                                                                    encoding:NSUTF8StringEncoding error:nil];
                                    
                                    //控制器自己dismiss
                                    [self dismissViewControllerAnimated:YES completion:nil];
                                    
                                }else{
                                    
                                    [SVProgressHUD showErrorWithStatus:@"验证失败"];
                                    
                                }
                            }];
    
}
#pragma mark - 语音获取验证码
- (IBAction)voiceRegisterBtn:(UIButton *)sender {
    
    sender.enabled = !sender.enabled;
    
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodVoice
                            phoneNumber:self.nameTextField.text
                                   zone:@"86"
                       customIdentifier:nil
                                 result:^(NSError *error) {
                                     if (!error) {
                                         [SVProgressHUD showSuccessWithStatus:@"获取成功"];
                                         
                                         sender.enabled = !sender.enabled;
                                         
                                     }else{
                                         
                                         [SVProgressHUD showErrorWithStatus:@"手机号有误"];
                                         
                                         sender.enabled = !sender.enabled;
                                         
                                     }
                                 }];
    
    
}
#pragma mark - 短信获取验证码
- (IBAction)registerBtn:(UIButton *)sender {
    //不能点
    sender.enabled = !sender.enabled;
    
    NSLog(@"%d",sender.enabled);
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS
                            phoneNumber:self.nameTextField.text
                                   zone:@"86"
                       customIdentifier:nil
                                 result:^(NSError *error) {
                                     if (!error) {
                                        [SVProgressHUD showSuccessWithStatus:@"获取成功"];
                                         
                                         self.count = 60;
                                         //初始化计时器
                                         self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
                                         //设置按钮点击后，改变title的内容
                                         [self.smsRegisterBtn setTitle:[NSString stringWithFormat:@"%ld秒后重新发送",self.count] forState:UIControlStateNormal];
                                         [self.smsRegisterBtn setBackgroundColor:[UIColor lightGrayColor]];
                                         
                                         
                                         
                                     }else{
                                         [SVProgressHUD showErrorWithStatus:@"手机号有误"];
                                         //能点
                                         sender.enabled = !sender.enabled;
                                         NSLog(@"%d",sender.enabled);

                                     }
                                 }];
    
}

-(void)timerAction{
    //让倒计时时间减少，间隔为1
    self.count -- ;
    //更新按钮title的内容
    self.smsRegisterBtn.titleLabel.text = [NSString stringWithFormat:@"%ld秒后重新发送",self.count] ;
    [self.smsRegisterBtn setTitle:[NSString stringWithFormat:@"%ld秒后重新发送",self.count] forState:UIControlStateNormal];
    //停止按钮的交互
    self.smsRegisterBtn.userInteractionEnabled = NO;
    //当倒计时时间结束时，销毁掉计时器，恢复按钮的交互，同时也更新按钮的title
    if (self.count == 0) {
        [self.timer invalidate];
        self.smsRegisterBtn.userInteractionEnabled = YES;
        [self.smsRegisterBtn setTitle:@"重新发送" forState:UIControlStateNormal];
    }
}

//微博登陆
- (IBAction)WebBtn:(UIButton *)sender {
    
    [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        
        
        NSLog(@"%lu",(unsigned long)state);
        if (state == SSDKResponseStateSuccess)
        {
            
            NSLog(@"uid=%@",user.uid);
            NSLog(@"%@",user.credential);
            NSLog(@"token=%@",user.credential.token);
            NSLog(@"nickname=%@",user.nickname);
            
            
            NSString *cachesDirPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"name.db"];
            
            
            [user.nickname writeToFile:cachesDirPath atomically:YES
                         encoding:NSUTF8StringEncoding error:nil];
            
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
        
    }];
    
    
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeSinaWeibo
                                   onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
                                       
                                       //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
                                       //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
                                       
                                       associateHandler (user.uid, user, user);
                                       NSLog(@"dd%@",user.rawData);
                                       NSLog(@"dd%@",user.credential);
                                       
                                   }
                                onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
                                    
                                    if (state == SSDKResponseStateSuccess)
                                    {
                                        
                                    }
                                    
                                }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_nameTextField resignFirstResponder];
    [_passwordField resignFirstResponder];
}



@end
