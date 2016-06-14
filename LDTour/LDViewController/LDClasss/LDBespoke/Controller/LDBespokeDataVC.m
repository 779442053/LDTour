//
//  LDBespokeDataVC.m
//  LDTour
//
//  Created by Daredos on 16/6/14.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDBespokeDataVC.h"
#import "LDBespokeDataWebVC.h"
#import "MJRefresh.h"

@interface LDBespokeDataVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *bespokeDataTableView;
@property (strong, nonatomic) NSMutableArray *bespokeDataArray;

@property (assign, nonatomic) int start;
@property (assign, nonatomic) int count;

@end

@implementation LDBespokeDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _start = 0;
    _count = 20;
    
    [self.bespokeDataTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    // 添加下拉和上拉刷新控件
    self.bespokeDataTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.start = 0;
        [self.bespokeDataTableView.header beginRefreshing];
        [self startDownloadData];
    }];
    
    self.bespokeDataTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.start++;
        [self.bespokeDataTableView.footer beginRefreshing];
        [self startDownloadData];
    }];
    
    [self.bespokeDataTableView.header beginRefreshing];
}

- (void)startDownloadData {

    [SVProgressHUD showWithStatus:@""];

    [LDHHTTPSessionManager getWxarticleListRequestByCIDWithCid:self.cid start:_start count:_count netIdentifier:@"data" downloadProgressBlock:nil successBlock:^(id responseObject) {
        [SVProgressHUD dismiss];
        if (self.start == 0) {
            [self.bespokeDataArray removeAllObjects];
        }
        [self.bespokeDataArray addObjectsFromArray:responseObject[@"list"]];
        
        [self.bespokeDataTableView reloadData];
        [self.bespokeDataTableView.header endRefreshing];
        [self.bespokeDataTableView.footer endRefreshing];

    } failureBlock:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:error.domain];
        [self.bespokeDataTableView.header endRefreshing];
        [self.bespokeDataTableView.footer endRefreshing];

    }];
}

#pragma mark -
#pragma mark - init
#pragma mark - 生命周期
#pragma mark - getters setters
- (NSMutableArray *)bespokeArray {
    
    if (!_bespokeDataArray) {
        
        _bespokeDataArray = @[].mutableCopy;
    }
    return _bespokeDataArray;
}

#pragma mark - 系统delegate
#pragma mark - 自定义delegate
#pragma mark - 公有方法
#pragma mark - 私有方法
#pragma mark - 事件响应

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.bespokeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSDictionary *dict = self.bespokeArray[indexPath.row];
    cell.textLabel.text = dict[@"subTitle"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    LDBespokeDataWebVC *c = [LDBespokeDataWebVC new];
    NSDictionary *dict = self.bespokeArray[indexPath.row];
    c.title = dict[@"subTitle"];
    c.url   = dict[@"sourceUrl"];
    [self.navigationController pushViewController:c animated:YES];
}

@end
