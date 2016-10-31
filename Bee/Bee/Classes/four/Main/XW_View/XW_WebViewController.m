//
//  XW_WebViewController.m
//  Bee
//
//  Created by 9264 on 16/9/10.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "XW_WebViewController.h"
#import "XW_HomeVC.h"
#import "SCanQRCodeViewController.h"

@interface XW_WebViewController ()

@end

@implementation XW_WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webV = [[UIWebView alloc]initWithFrame:self.view.bounds];
    NSURL *url  = [NSURL URLWithString:_jumpString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webV loadRequest:request];
    [self.view addSubview:webV];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    UIButton *returnButton = [UIButton bee_buttonWithTitle:@" ⬅︎返回" andFontSize:18 andNormalColor:[UIColor orangeColor] andSelectedColor:[UIColor redColor]];
    
    [returnButton addTarget:self action:@selector(jumpToHome) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:returnButton];

    [returnButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.view).offset(25);
    }];
}

- (void)jumpToHome{
//    if (self.tag == 9264) {
//        SCanQRCodeViewController *scan = [[SCanQRCodeViewController alloc] init];
//        [self.navigationController pushViewController:scan animated:YES];
//    }else{
    [self.navigationController popViewControllerAnimated:YES];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
