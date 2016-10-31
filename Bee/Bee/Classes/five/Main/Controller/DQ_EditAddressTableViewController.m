//
//  DQ_EditAddressTableViewController.m
//  Bee
//
//  Created by Apple on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "DQ_EditAddressTableViewController.h"
#import "BeeFMDatabaseQueue.h"
#import "DQ_AddressModel.h"


static NSString *EditAdressCell = @"EditAdressCell";

@interface DQ_EditAddressTableViewController ()
//先生按钮
@property(weak,nonatomic)IBOutlet UIButton *maleButton;
//女士按钮
@property(weak,nonatomic)IBOutlet UIButton *femaleButton;
//联系人
@property(weak,nonatomic)IBOutlet UITextField *nameLabel;
//手机号
@property(weak,nonatomic)IBOutlet UITextField *phoneNumLabel;
//城市
@property(weak,nonatomic)IBOutlet UITextField *cityLabel;
//地址
@property(weak,nonatomic)IBOutlet UITextField *addressLabel;
//门票号
@property(weak,nonatomic)IBOutlet UITextField *houseNumLabel;


@end

@implementation DQ_EditAddressTableViewController{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //右侧保存按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveInfo)];
    
    [self setupUI];
}
#pragma mark -按钮点击事件
//先生按钮
-(IBAction)maleButtonClick:(id)sender{
    _maleButton.selected = YES;
    _femaleButton.selected = NO;
}

//女士按钮
-(IBAction)femaleButtonClick:(id)sender{
    _femaleButton.selected = YES;
    _maleButton.selected = NO;
}

#pragma mark -搭建界面
-(void)setupUI{
    //判断navigationitem的title
    if (_entranceId == 1) {
        self.navigationItem.title = @"新增地址";
    }else if(_entranceId == 2){
        self.navigationItem.title = @"编辑地址";
        //填充子控件
        _nameLabel.text = _model.name;
        //判断性别
        if ([_model.isMale isEqualToString:@"1"]) {
            //男的
            _maleButton.selected = YES;
            
        }else{
            //女的
            _femaleButton.selected = YES;
        }
        _phoneNumLabel.text = _model.phoneNum;
        _cityLabel.text = _model.city;
        _addressLabel.text = _model.address;
        _houseNumLabel.text = _model.houseNum;
        //动态增加一个按钮
        UIButton *button = [UIButton bee_buttonWithTitle:@"删除地址" andFontSize:14 andNormalColor:[UIColor blackColor] andSelectedColor:nil];
        [button setBackgroundColor:[UIColor grayColor]];
        button.alpha = 0.6;
        button.frame = CGRectMake(0, 0, self.view.frame.size.width, 30);
        button.layer.cornerRadius = 5;
        [button sizeToFit];
        self.tableView.tableFooterView = button;
        //点击事件
        [button addTarget:self action:@selector(deleteAddress) forControlEvents:UIControlEventTouchUpInside];
    }
    
}
#pragma mark -点击事件
-(void)deleteAddress{
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteAddress" object:_model];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -保存地址信息
-(void)saveInfo{
    //判断是保存还是编辑已有信息
    if (_entranceId == 1) {
        //1.新增数据,获取用户填写的字段
        //1.1实例化地址模型
        _model = [[DQ_AddressModel alloc]init];
    }
    //1.2获取新增字段
    _model.name = _nameLabel.text;
    if (_maleButton.selected == YES) {
        _model.isMale = @"1";
    }
    if (_femaleButton.selected == YES) {
        _model.isMale = @"2";
    }
    _model.phoneNum = _phoneNumLabel.text;
    _model.city = _cityLabel.text;
    _model.address = _addressLabel.text;
    _model.houseNum = _houseNumLabel.text;
    //1.3 只有当所有字段都有值才发送通知并回调
    if (_model.name.length == 0 && _model.isMale.length  == 0 && _model.phoneNum.length == 0 && _model.city.length  == 0 && _model.address.length == 0 && _model.houseNum.length == 0) {
        //什么都不写直接跳回
        [self.navigationController popViewControllerAnimated:YES];
    }else if(_model.name.length == 0 || _model.isMale.length  == 0 || _model.phoneNum.length == 0 || _model.city.length  == 0 || _model.address.length == 0 || _model.houseNum.length == 0){
        //填写某些项目提示
        NSLog(@"请填写完整信息");
    }else if(_model.name.length && _model.isMale.length && _model.phoneNum.length && _model.city.length && _model.address.length && _model.houseNum.length){
        //填写完整项目跳回
        //判断是新增还是编辑,分别通知
        if (_entranceId == 1) {
            //新增事件
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SaveAddress" object:_model];
        }else{
            //编辑事件
            [[NSNotificationCenter defaultCenter] postNotificationName:@"EditAddress" object:_model];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

@end
