//
//  DQ_AddressTableViewController.m
//  Bee
//
//  Created by Apple on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "DQ_AddressTableViewController.h"
#import "DQ_EditAddressTableViewController.h"
#import "DQ_AddAdressCell.h"
#import "DQ_AddressModel.h"
#import "BeeFMDatabaseQueue.h"
static NSString *Add_Adress = @"Add_Adress";

@interface DQ_AddressTableViewController ()<UITableViewDataSource,UITableViewDelegate>
//传递过来的模型全局化
@property(strong,nonatomic)DQ_AddressModel *model;

@end

@implementation DQ_AddressTableViewController{
    //地址模型数组
    NSMutableArray <DQ_AddressModel *>*_addressArry;
    //数据库管理者全局化
    BeeFMDatabaseQueue *_manager;
    //tableView全局化
    UITableView *_tableV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    //实例化数据库管理者
    _manager = [BeeFMDatabaseQueue sharedQueue];
    //实例化模型数组
    _addressArry = [NSMutableArray array];
    [self loadData];
    
    [self setupUI];
    
    //注册新增地址的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SaveAddress:) name:@"SaveAddress" object:nil];
    //注册眺转到编辑控制器的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoEdit:) name:@"gotoEdit" object:nil];
    //注册编辑地址的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EditAddress:) name:@"EditAddress" object:nil];
    //注册删除地址的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteAddress:) name:@"deleteAddress" object:nil];
}

#pragma mark -删除地址事件
-(void)deleteAddress:(NSNotification *)notification{
    //1.获取传入编辑地址的模型
    DQ_AddressModel *deleteModel = notification.object;
    //2.获取模型对应的cellID
    NSString *cellID = deleteModel.cellID;
    //3.删除对应的cell
    NSString *delete_SQL = @"delete from t_beeAddress where id = ?;";
    [_manager inDatabase:^(FMDatabase *db) {
        BOOL isOK = [db executeUpdate:delete_SQL,cellID];
        if (isOK) {
            //更新数据成功,刷新UI
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                //数组中移除对应的行
                [_addressArry removeObjectAtIndex:deleteModel.indexpath.row];
                [_tableV reloadData];
            }];
        }
    }];
}

#pragma mark -新增地址持久化
-(void)saveData{
    //@"create table if not exists t_beeAddress(id integer primary key not null,name text,isMale integer,phoneNum text,city text,address text,houseNum text);";
    NSString *name = _model.name;
    NSString *isMale = _model.isMale;
    NSString *phoneNum = _model.phoneNum;
    NSString *city = _model.city;
    NSString *address = _model.address;
    NSString *houseNum = _model.houseNum;
    //获取数据库中的id,此时cellID在此基础上增加
    // 1.定义SQL语句
    NSString *updateSQL = @"select id from t_beeAddress;";
    // 2.队列调度数据库
    //定义最大值
    __block int max = INT32_MIN;
    [_manager inDatabase:^(FMDatabase *db) {
        // 3.执行SQL
        FMResultSet *resultSet = [db executeQuery:updateSQL];
        // 4.逐条取记录
        while ([resultSet next]) {
            int idNum = [resultSet intForColumn:@"id"];
            //取出最大值
            max = idNum >= max ? idNum+1 : max;
        }
    }];
    if (max == INT32_MIN) {
        max = 1;
    }
    NSInteger num = max;
    NSString *cellID = [NSString stringWithFormat:@"%zd",num];
    // 1.定义SQL语句
    NSString *insertSQL = @"insert into t_beeAddress(name,isMale,phoneNum,city,address,houseNum,cellID) values(?,?,?,?,?,?,?);";
    
    // 2.队列调度数据库
    [_manager inDatabase:^(FMDatabase *db) {
        
        // 3.执行SQL   BOOL isOK = [db executeUpdate:insertSQL,name,@(18)];
    [db executeUpdate:insertSQL,name,isMale,phoneNum,city,address,houseNum,cellID,_model.name,_model.isMale,_model.phoneNum,_model.city,_model.address,_model.houseNum,cellID];
    }];
    [_tableV reloadData];
}

#pragma mark -编辑地址通知事件
-(void)EditAddress:(NSNotification *)notification{
    //修改对应的数据库信息
    //1.获取传回来的模型
    DQ_AddressModel *model = notification.object;
    NSInteger ID = model.indexpath.row + 1;
    int int_ID = @(ID).intValue;
    //@"create table if not exists t_beeAddress(id integer primary key not null,name text,isMale integer,phoneNum text,city text,address text,houseNum text);";
    // 3.定义SQL语句 //isMale = ? , phoneNum = ? , city = ? , address = ? , houseNum = ?
    NSString *updateSQL = @"update t_beeAddress set name = ? , isMale = ? , phoneNum = ? , city = ? , address = ? , houseNum = ? where id = ?;";
    // 4.队列调度数据库
    [_manager inDatabase:^(FMDatabase *db) {
        // 执行SQL //,isMale,phoneNum,city,address,houseNum,_model.name,_model.isMale,_model.phoneNum,_model.city,_model.address,_model.houseNum
        BOOL isOK = [db executeUpdate:updateSQL,model.name,model.isMale,model.phoneNum,model.city,model.address,model.houseNum,@(int_ID)];
        if (isOK) {
            //更新数据成功,刷新UI
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [_tableV reloadData];
            }];
        }
    }];
}

#pragma mark -新增地址通知事件
-(void)SaveAddress:(NSNotification *)notification{
    //获取传过来的模型
    _model = notification.object;
    
    if (_addressArry == nil) {
        [_addressArry insertObject:_model atIndex:0];
    }else{
        [_addressArry insertObject:_model atIndex:_addressArry.count];
    }

    [_tableV insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_addressArry.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
    [self saveData];
}

#pragma mark -加载数据
-(void)loadData{
    //获取本地数据库的信息
    //@"create table if not exists t_beeAddress(id integer primary key not null,name text,isMale integer,phoneNum text,city text,address text,houseNum text);";
    //1.定义查询语句
    NSString *querySQL = @"select name,phoneNum,city,address,houseNum,cellID from t_beeAddress";
    //2.执行查询语句
    [_manager inDatabase:^(FMDatabase *db) {
        // 拿到查询之后的结果集
        FMResultSet *resultSet = [db executeQuery:querySQL];
        // 循环遍历结果集 : 会自动检测下一条记录有没有
        while ([resultSet next]) {
            //2.1 创建地址模型
            DQ_AddressModel *model = [[DQ_AddressModel alloc]init];
            // 逐条取出记录
            model.name = [resultSet stringForColumn:@"name"];
            model.phoneNum = [resultSet stringForColumn:@"phoneNum"];
            model.city = [resultSet stringForColumn:@"city"];
            model.houseNum = [resultSet stringForColumn:@"houseNum"];
            model.address = [resultSet stringForColumn:@"address"];
            //取出cellID
            model.cellID = [resultSet stringForColumn:@"cellID"];
            //将模型保存至数组
            [_addressArry addObject:model];
        }
    }];
    //如果数组为空,则执行新增
    if (_addressArry == nil) {
        _addressArry = [NSMutableArray array];
    }
}
#pragma mark -自定义左侧返回按钮
-(void)backAction:(id)sender{
    //通知传出模型数组
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AddressCount" object:_addressArry];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -搭建界面
-(void)setupUI{
    //1.设置navi的item样式
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(backAction:)];
    
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"送货上门",@"店铺自提"]];
    segment.tintColor = [UIColor bee_colorWithRed:252 andGreen:211 andBlue:69 andAlpha:1.0];
    segment.selectedSegmentIndex = 0;
    [segment setTitleTextAttributes:@{
                                      NSFontAttributeName : [UIFont systemFontOfSize:13]
                                      } forState:UIControlStateNormal];
    self.navigationItem.titleView = segment;
    
    //2.设置底部视图
    UIView *bottomV = [[UIView alloc]init];
    bottomV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomV];
    [bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    //2.1给底部视图增加按钮
    UIButton *addBtn = [UIButton bee_buttonWithTitle:@"+ 新增地址" andFontSize:14 andNormalColor:[UIColor blackColor] andSelectedColor:nil];
    [bottomV addSubview:addBtn];
    //2.2 设置按钮的边框
    [addBtn.layer setMasksToBounds:YES];
    [addBtn.layer setCornerRadius:5];
    //2.3设置边框颜色
    addBtn.backgroundColor = [UIColor bee_colorWithRed:252 andGreen:211 andBlue:69 andAlpha:1.0];
    //2.4设置按钮的约束
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomV);
        make.top.equalTo(bottomV.mas_top).offset(10);
        make.width.mas_equalTo(200);
    }];
    //2.5按钮点击事件
    [addBtn addTarget:self action:@selector(addAddress:) forControlEvents:UIControlEventTouchUpInside];
    
    //3.设置中间的tableView
    UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:tableV];
    _tableV = tableV;
    [tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(bottomV.mas_top);
    }];
    //3.1 设置代理
    tableV.dataSource = self;
    tableV.delegate = self;
    [tableV registerClass:[DQ_AddAdressCell class] forCellReuseIdentifier:Add_Adress];
    //4.设置自动计算行高
    tableV.estimatedRowHeight = 100;
    tableV.rowHeight = UITableViewAutomaticDimension;
    [_tableV reloadData];
}

#pragma mark -编辑按钮通知
-(void)gotoEdit:(NSNotification *)notification{
    //获取按钮所在的cell
    DQ_AddAdressCell *cell = notification.object;
    //获取cell所在的下标
    NSIndexPath *indexPath = [_tableV indexPathForCell:cell];
    //获取cell所在的模型
    DQ_AddressModel *editModel = _addressArry[indexPath.row];
    //保存cell所在的下标到模型
    editModel.indexpath = indexPath;
    //点击跳转到增加地址控制器
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"DQ_EditAddressTableViewController" bundle:nil];
    DQ_EditAddressTableViewController *editVC = [sb instantiateInitialViewController];
    //传入接口数据
    editVC.entranceId = 2;
    editVC.model = editModel;
    [self.navigationController pushViewController:editVC animated:YES];
    //返回按钮设置为不保留文字的样式
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                 style:UIBarButtonItemStyleDone
                                                                target:nil
                                                                action:nil];
    
    [self.navigationItem setBackBarButtonItem:backItem];
}

#pragma mark -新增按钮点击事件
-(void)addAddress:(UIButton *)sender{
    //点击跳转到增加地址控制器
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"DQ_EditAddressTableViewController" bundle:nil];
    DQ_EditAddressTableViewController *editVC = [sb instantiateInitialViewController];
    editVC.entranceId = 1;
    [self.navigationController pushViewController:editVC animated:YES];
    //返回按钮设置为不保留文字的样式
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                 style:UIBarButtonItemStyleDone
                                                                target:nil
                                                                action:nil];
    
    [self.navigationItem setBackBarButtonItem:backItem];
    
}
#pragma mark -UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取选中cell的模型
    DQ_AddressModel *model = _addressArry[indexPath.row];
    //通知传值
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowAddress" object:model];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _addressArry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DQ_AddAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:Add_Adress forIndexPath:indexPath];
    cell.model = _addressArry[indexPath.row];
    return cell;
}

#pragma mark - 移除通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
