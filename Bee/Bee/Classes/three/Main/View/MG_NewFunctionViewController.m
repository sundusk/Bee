//
//  MG_NewFunctionViewController.m
//  Bee
//
//  Created by apple on 16/9/10.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "MG_NewFunctionViewController.h"
#import "XW_HomeVC.h"
#import "YS_TabbarVC.h"

@interface MG_NewFunctionViewController ()<UIScrollViewDelegate>

@end

@implementation MG_NewFunctionViewController{
    //保存下边pageControl
    UIPageControl *_pageControl;
    //保存scrollView
    UIScrollView *_functionView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}


- (void)setupUI{
    UIScrollView *functionView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    NSInteger scroViewCount = 3;
    //隐藏滚动指示条
    functionView.showsVerticalScrollIndicator = NO;
    functionView.showsHorizontalScrollIndicator = NO;
    //分页
    functionView.pagingEnabled = YES;
    //关闭弹簧效果
    functionView.bounces = NO;
    //设置scrollView的代理为新特性界面
    functionView.delegate = self;
    functionView.contentSize = CGSizeMake(scroViewCount * self.view.frame.size.width, 0);
    for (NSInteger i = 0; i < scroViewCount; i++) {
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"start%zd",i+1]];
        UIImageView *picture = [[UIImageView alloc]initWithImage:image];
        
        picture.frame = CGRectMake(i * self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
        picture.userInteractionEnabled = YES;
        [functionView addSubview:picture];
        //设置Button在scrollView的最后一页显示
        if (i == scroViewCount - 1) {
            UIButton *btnGoVc = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnGoVc setBackgroundImage:[UIImage imageNamed:@"icon_next"] forState:UIControlStateNormal];
            [btnGoVc addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
            [picture addSubview:btnGoVc];
            _btnGoVc = btnGoVc;
            [btnGoVc mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(picture.mas_centerX);
                make.bottom.equalTo(picture).offset(-30);
                make.size.mas_equalTo(CGSizeMake(100, 40));
            }];
        }
    }
    [self.view addSubview:functionView];
    _functionView = functionView;
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    
    //设置位置
    pageControl.center = self.view.center;
    
    //设置非当前的颜色
    pageControl.pageIndicatorTintColor = [UIColor clearColor];
    //设置当前页的颜色
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    //设置pagecontrol的页数
    pageControl.numberOfPages = scroViewCount;
    [self.view addSubview:pageControl];
    //关闭pageControl的点击
    pageControl.defersCurrentPageDisplay = YES;
    _pageControl = pageControl;
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
    }];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"xxxx");
    
    CGFloat offsetx = scrollView.contentOffset.x;
    //得到准确的float值的页码
    CGFloat page = offsetx / self.view.frame.size.width;
    //把float值的页码 + 0.5
    page += 0.5;
    _pageControl.currentPage = (NSInteger)page;
    
}
- (void)clickBtn{
    
//    NSLog(@"zzzzz");
    //去掉新特性界面
//    XW_HomeVC *homeVc = [[XW_HomeVC alloc]init];
//    [self.navigationController pushViewController:homeVc animated:YES];
    YS_TabbarVC *ys_tabVC = [[YS_TabbarVC alloc]init];
    [[UIApplication sharedApplication].keyWindow setRootViewController:ys_tabVC];
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
