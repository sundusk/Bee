//
//  CQ_NextViewController.m
//  CCQ_Demo
//
//  Created by 神威 on 16/9/11.
//  Copyright © 2016年 ccq. All rights reserved.
//

#import "CQ_NextViewController.h"
#import "YQ_ChaoShiVC.h"
#import "XW_HomeVC.h"

@interface CQ_NextViewController ()

@end

@implementation CQ_NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupUI];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"搜索结果";
    
}

#pragma mark - UI界面布局

- (void)setupUI{

    //上部 创建黄色View
    UIView *yellowView = [[UIView alloc]init];
    yellowView.backgroundColor = [UIColor yellowColor];
    yellowView.alpha = 0.5;
    
    [self.view addSubview:yellowView];

    [yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.right.left.equalTo(self.view);
        make.height.equalTo(@60);
    }];
    
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_exclamationmark"]];
    [yellowView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(yellowView).offset(8);
        make.width.height.equalTo(@40);
    }];
    
    UILabel *topLab = [[UILabel alloc]init];
    [yellowView addSubview:topLab];
    topLab.text = @"暂时没有搜到相关商品，可能过期或下架";
    [topLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(yellowView).offset(6);
        make.left.equalTo(yellowView).offset(50);
    }];
    
    UILabel *bowLab = [[UILabel alloc]init];
    [yellowView addSubview:bowLab];
    bowLab.font = [UIFont systemFontOfSize:14];
    bowLab.text = @"换成其他关键词试试看，但是并没有什么卵用";
    bowLab.textColor = [UIColor orangeColor];
    
    [bowLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(yellowView).offset(-6);
        make.left.equalTo(yellowView).offset(50);
    }];
    
    
    //下部创建跳转按钮
    UILabel *oLabel = [[UILabel alloc]init];
    oLabel.text  =  @"您还可以：";
    oLabel.textColor =  [UIColor grayColor];
    [self.view addSubview:oLabel];
    
    [oLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(120);
        make.left.equalTo(self.view).offset(30);
    }];
    
    UIButton *homeBth = [[UIButton alloc]init];
    [homeBth setTitle:@"返回首页看看" forState:UIControlStateNormal];
    [homeBth setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [homeBth addTarget:self action:@selector(homeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homeBth];
    
    [homeBth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).offset(-20);
        make.centerY.equalTo(self.view).offset(-100);
        
    }];
    UIButton *shopBth = [[UIButton alloc]init];
    [shopBth setTitle:@"去闪电超市看看" forState:UIControlStateNormal];
    [shopBth addTarget:self action:@selector(shopClick) forControlEvents:UIControlEventTouchUpInside];
    [shopBth setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:shopBth];
    
    [shopBth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).offset(-20);
        make.centerY.equalTo(self.view).offset(-60);
        
    }];
    
    
}

#pragma mark - 实现按钮点击事件

- (void)shopClick{
    
    YQ_ChaoShiVC *vc = [[YQ_ChaoShiVC alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)homeClick{
    XW_HomeVC *vc = [[XW_HomeVC alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
