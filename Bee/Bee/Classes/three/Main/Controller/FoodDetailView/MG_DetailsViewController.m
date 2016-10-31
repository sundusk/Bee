//
//  MG_DetailsViewController.m
//  Bee
//
//  Created by apple on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "MG_DetailsViewController.h"
#import "DQ_MainVC.h"
#import "MG_DetailsTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface MG_DetailsViewController ()<UITableViewDataSource,UITableViewDelegate>
/**
 *  保存所有已经被用户选择产品模型
 */
@property(strong, nonatomic) NSMutableArray *carList;
@end

@implementation MG_DetailsViewController{
    NSInteger _num;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupUI];
    NSLog(@"%@",self.freshModel);
    _carList = [NSMutableArray array];
}

- (void)setupUI{
    self.tabBarController.tabBar.hidden = YES;
    
    UITableView *detailView = [[UITableView alloc]init];
    detailView.dataSource = self;
    detailView.delegate = self;
    [self.view addSubview:detailView];
    UITabBarItem *tableItem = [[[self.tabBarController tabBar]items]objectAtIndex:2];
    NSLog(@"%@",tableItem.badgeValue);
    
    NSString *URLString;
    if (_freshModel == nil) {
        URLString = self.productsModel.img;
    }else{
        URLString = self.freshModel.img;
    }
    NSURL *url = [NSURL URLWithString:URLString];
    UIImageView *imageV = [[UIImageView alloc]init];
    [imageV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"angle-mask@3x"]];
    imageV.frame = CGRectMake(0, 0, self.view.bounds.size.width, 400);
    detailView.tableHeaderView = imageV;
    detailView.tableHeaderView.contentMode = UIViewContentModeScaleAspectFill;
    [detailView registerNib:[UINib nibWithNibName:@"DetailSTableViewCell" bundle:nil] forCellReuseIdentifier:@"PriceCell"];
    [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MG_DetailsTableViewCell *detailCell = [tableView dequeueReusableCellWithIdentifier:@"PriceCell" forIndexPath:indexPath];
    detailCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_productsModel != nil) {
        detailCell.YQModel = _productsModel;
    }else{
        detailCell.XWmodel = _freshModel;
    }
    return detailCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 290;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
    //其他代码
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resoxurces that can be recreated.
}
- (void)viewWillDisappear:(BOOL)animated{
    
    
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
