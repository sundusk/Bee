//
//  QRService.h
//  QRCode
//
//  Created by LeeWong on 16/9/6.
//  Copyright © 2016年 LeeWong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>


@interface QRService : NSObject

+ (instancetype)shared;

/**
 *  扫描二维码的方法
 *
 *  @param windowSize 显示位置
 *  @param viewSize   可以传递屏幕尺寸
 *  @param scanResult 扫描结果的字符串
 *
 *  @return 返回扫描的layer 需要使用者添加到需要显示扫描效果的view上
 */
- (AVCaptureVideoPreviewLayer *)scanQRImage:(CGRect)windowSize
                                   viewSize:(CGRect)viewSize
                                     result:(void (^)(NSString *aQRCode))scanResult;


@end
