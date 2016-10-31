//
//  YQ_MsgVC.m
//  Bee
//
//  Created by 黄跃奇 on 16/9/9.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "YQ_MsgVC.h"
#import "DSHTTPClient.h"
#import "YQ_SystemMessageModel.h"
#import "YYModel.h"
#import "YQ_SystemMessageCell.h"
#import "YQ_SystemMessageFooterView.h"

static NSString *messageID = @"messageID";

static NSString *footerID = @"footerID";

@interface YQ_MsgVC () <UITableViewDataSource, UITableViewDelegate>

@property(weak, nonatomic) UITableView *tvMessage;

@end

@implementation YQ_MsgVC {
    
    NSArray *_messageList;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSystemMessageData];
    [self setupUI];
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    YQ_SystemMessageFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerID];
    return footerView;
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _messageList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YQ_SystemMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:messageID forIndexPath:indexPath];
    YQ_SystemMessageModel *messageModel = _messageList[indexPath.section];
    cell.messageModel = messageModel;
    return cell;
}

#pragma mark - 加载数据
- (void)loadSystemMessageData {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setValue:@"10" forKey:@"call"];
    
    [DSHTTPClient postUrlString:@"SystemMessage.json.php" withParam:param withSuccessBlock:^(id data) {
        
        NSArray *result =  data[@"data"];
        
        _messageList = [NSArray yy_modelArrayWithClass:[YQ_SystemMessageModel class] json:result];
        
        [self.tvMessage reloadData];
        
    } withFailedBlock:^(NSError *error) {
        NSLog(@"%@",error);
    } withErrorBlock:^(NSString *message) {
        NSLog(@"%@",message);
    }];
    
}

#pragma mark - 设置UI界面
- (void)setupUI {
    
    self.navigationController.navigationBar.backgroundColor = [UIColor lightGrayColor];
    
    //1. 导航内容
    //1.1 segment控件
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"系统消息", @"用户消息"]];
    
    //1.2 设置宽度
    [segment setWidth:80 forSegmentAtIndex:0];
    [segment setWidth:80 forSegmentAtIndex:1];
    
    //1.3 设置默认选中
    [segment setSelectedSegmentIndex:0];
    
    segment.backgroundColor = [UIColor orangeColor];
    
    self.navigationItem.titleView = segment;
    
    UITableView *tvMessage = [[UITableView alloc] initWithFrame:self.view.bounds];
    
    tvMessage.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:tvMessage];
    
    tvMessage.rowHeight = 100;
    
    tvMessage.dataSource = self;
    tvMessage.delegate = self;
    
    tvMessage.tableFooterView = [[UIView alloc] init];
    
    //注册cell
    [tvMessage registerClass:[YQ_SystemMessageCell class] forCellReuseIdentifier:messageID];
    
    //注册组尾footerView
    [tvMessage registerClass:[YQ_SystemMessageFooterView class] forHeaderFooterViewReuseIdentifier:footerID];
    
    tvMessage.sectionFooterHeight = 23;
    
    self.tvMessage = tvMessage;
    
}

@end
