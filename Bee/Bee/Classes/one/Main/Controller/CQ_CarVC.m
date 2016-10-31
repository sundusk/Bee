//
//  CCQMainVC.m
//  NBApp
//
//  Created by yaoshuai on 16/9/6.
//  Copyright © 2016年 ys. All rights reserved.
//
////////////////////////////////////////////////////////////////////
//                          _ooOoo_                               //
//                         o8888888o                              //
//                         88" . "88                              //
//                         (| ^_^ |)                              //
//                         O\  =  /O                              //
//                      ____/`---'\____                           //
//                    .'  \\|     |//  `.                         //
//                   /  \\|||  :  |||//  \                        //
//                  /  _||||| -:- |||||-  \                       //
//                  |   | \\\  -  /// |   |                       //
//                  | \_|  ''\---/''  |   |                       //
//                  \  .-\__  `-`  ___/-. /                       //
//                ___`. .'  /--.--\  `. . ___                     //
//              ."" '<  `.___\_<|>_/___.'  >'"".                  //
//            | | :  `- \`.;`\ _ /`;.`/ - ` : | |                 //
//            \  \ `-.   \_ __\ /__ _/   .-` /  /                 //
//      ========`-.____`-.___\_____/___.-`____.-'========         //
//                           `=---='                              //
//      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        //
//         佛祖保佑            永无BUG              永不修改         //
////////////////////////////////////////////////////////////////////
#import "CQ_CarVC.h"
#import "CQ_PaymentView.h"
#import "CQ_DiscountTableViewCell.h"
#import "CQ_CastTableViewCell.h"
#import "CQ_CommodityTableViewCell.h"
#import "CQ_PayTableViewCell.h"
#import "CQ_HistoryViewController.h"
#import "YS_QuanVC.h"
/**
 *  总价格
 */
static NSString *money = @"$12.5";
//cell注册
static NSString *cellID = @"cellID";
static NSString *discountCell = @"discountCell";
static NSString *payCell = @"payCell";
static NSString *commodityCell = @"commodityCell";
static NSString *castCell = @"castCell";
@interface CQ_CarVC ()<UITableViewDataSource,UITableViewDelegate>
/**
 *  全局tableView
 */
@property(nonatomic ,strong)UITableView *tableView;

@property(nonatomic ,assign)NSInteger indexRow;

@property (weak , nonatomic) UILabel *label;

/**
 *  总价格
 */
@property (weak , nonatomic) UILabel *numLabel;


@end

@implementation CQ_CarVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupUI];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"结算付款";
    
    
}

#pragma mark - 布局界面
- (void)setupUI
{
   
    //创建底部付款
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CQ_Payment" owner:self options:nil];
    CQ_PaymentView *payment = [nib objectAtIndex:0];
    payment.paymentLabel.text = @(_allNum).description;
   
    
    [self.view addSubview:payment];
    [payment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    
    //创建table
    UITableView *payTable = [[UITableView alloc]init];
    payTable.backgroundColor = [UIColor colorWithRed:239 green:239 blue:239 alpha:0];
    
    _tableView = payTable;
    
    [self.view addSubview:payTable];
    
    [payTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(payment.mas_top);
    }];
    
    //指定高度
    payTable.rowHeight = 40;
    
    //指定数据源
    payTable.dataSource = self;
    payTable.delegate = self;
    
    //注册cell
    [payTable registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    [payTable registerNib:[UINib nibWithNibName:@"CQ_DiscountCell" bundle:nil] forCellReuseIdentifier:discountCell];
    [payTable registerNib:[UINib nibWithNibName:@"CQ_PayCell" bundle:nil] forCellReuseIdentifier:payCell];
    [payTable registerNib:[UINib nibWithNibName:@"CQ_Commodit" bundle:nil] forCellReuseIdentifier:commodityCell];
    [payTable registerNib:[UINib nibWithNibName:@"CQ_CastCell" bundle:nil] forCellReuseIdentifier:castCell];
    
}


#pragma mark - 实现数据源方法


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 5;
        case 2:
            return _commodity.count;//_commodity.count 数据数量
        case 3:
            return 5;
            
        default:
            return 0;
    }
    
    
}

#pragma mark - UITableViewCell


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //优惠券cell
    if (indexPath.section == 0) {
        CQ_DiscountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:discountCell forIndexPath:indexPath];
        [cell.lookButton addTarget:self action:@selector(lookClick) forControlEvents:UIControlEventTouchUpInside ];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    //支付方式cell
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
           
            cell.textLabel.text = @"选择支付方式";
            cell.textLabel.font = [UIFont systemFontOfSize:11];
            cell.textLabel.textColor = [UIColor grayColor];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }
        CQ_PayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:payCell forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        if (indexPath.row == 1) {
            cell.payNameLabel.text = @"微信支付";
            cell.payImageView.image = [UIImage imageNamed:@"v2_about_wechat_logo"];
            
        }
        if (indexPath.row == 2) {
            cell.payNameLabel.text = @"QQ钱包支付";
            cell.payImageView.image = [UIImage imageNamed:@"icon_qq"];
        }
        if (indexPath.row ==  3) {
            cell.payNameLabel.text = @"支付宝支付";
            cell.payImageView.image = [UIImage imageNamed:@"zhifubaoA"];
            
        }
        if (indexPath.row == 4) {
            cell.payNameLabel.text = @"货到付款";
            cell.payImageView.image = [UIImage imageNamed:@"v2_dao"];
        }
        
       
        
        //按钮点击选择支付类型
        [cell.payButton addTarget:self action:@selector(choosePressed:) forControlEvents:UIControlEventTouchUpInside];
        cell.payButton.tag=indexPath.row;
        
        if (self.indexRow == indexPath.row) {
            [cell.payButton setImage:[UIImage imageNamed:@"v2_selected"] forState:UIControlStateNormal];

        }else{
            [cell.payButton setImage:[UIImage imageNamed:@"v2_noselected"] forState:UIControlStateNormal];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    //选定商品cell
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
            
            cell.textLabel.text = @"精选商品";
            cell.textLabel.font = [UIFont systemFontOfSize:11];
            cell.textLabel.textColor = [UIColor grayColor];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
            
        }
        for (NSInteger i = 0; i < _commodity.count; i++) {
            if (indexPath.section == 2 && indexPath.row == i+1) {
                    CQ_CommodityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commodityCell forIndexPath:indexPath];
                cell.model = _commodity[i];
                cell.backgroundColor = [UIColor whiteColor];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                return cell;
            }
        }

        
    }
    //费用合计cell
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
            
            cell.textLabel.text = @"费用明细";
            cell.textLabel.font = [UIFont systemFontOfSize:11];
            cell.textLabel.textColor = [UIColor grayColor];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }

        CQ_CastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:castCell forIndexPath:indexPath];
        
        
        
        if (indexPath.row == 1) {
            cell.castNameLabel.text = @"商品总额";
            cell.totalPrice = _allNum;
        }
        if(indexPath.row ==2){
            cell.castNameLabel.text = @"配送费";
            cell.moneyLabel.text = @"$0";
        }
        if(indexPath.row ==3){
            cell.castNameLabel.text = @"服务费";
            cell.moneyLabel.text = @"$0";
        }
        if(indexPath.row == 4){
            cell.castNameLabel.text = @"优惠券";
            cell.moneyLabel.text = @"$5";
        }
       [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

#pragma mark - 定义组头高度


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }else{
        return 16;
    }
}
#pragma mark - 定义组尾高度

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section == 2){
        return 30;
    }else{
        return 0.1;
    }
        
}

//设置组尾内容
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    
    UIView *allView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    if (section == 2) {
        UILabel *numLabel = [[UILabel alloc]init];
        numLabel.text = @(_allNum).description;
        numLabel.font = [UIFont systemFontOfSize:14];
        numLabel.textColor = [UIColor redColor];
        [allView addSubview:numLabel];
        [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(allView).offset(-8);
            make.bottom.equalTo(allView).offset(-8);
        }];
        UILabel *allLabel = [[UILabel alloc]init];
        allLabel.text = @"合计：";
        allLabel.textColor = [UIColor redColor];
        allLabel.font = [UIFont systemFontOfSize:14];
        [allView addSubview:allLabel];
        [allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(numLabel).offset(-30);
            make.bottom.equalTo(allView).offset(-8);
        }];
        

    }
    
    
    return allView;
    
}
#pragma mark - 跳转到优惠界面

- (void)lookClick{
    
    YS_QuanVC *vc = [[YS_QuanVC alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 支付按钮点击刷新

-(void)choosePressed:(UIButton *)sender{
 
   self.indexRow=sender.tag;
   [self.tableView reloadData];

    self.view.backgroundColor = [UIColor whiteColor];
    

}




@end