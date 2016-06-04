//
//  LDRecommendationVC.m
//  LDTour
//
//  Created by Daredos on 16/6/4.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDRecommendationVC.h"
#import "LDRecommendationHeaderView.h"
#import "LDRecommendationOriginalityCell.h"
#import "LDRecommendationStoriesCell.h"
#import "LDRecommendationSectionHeaderView.h"
#import "MJRefresh.h"

@interface LDRecommendationVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *recommendationTableView;

@end

@implementation LDRecommendationVC

#pragma mark -
#pragma mark - init
#pragma mark - 生命周期

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setUI];
    
    [self startDownloadData];
}

#pragma mark - getters setters
#pragma mark - 系统delegate
#pragma mark - 自定义delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: indexPath.section == 0 ? @"LDRecommendationStoriesCell" : @"LDRecommendationOriginalityCell" ];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.000001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 200;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    LDRecommendationSectionHeaderView *head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LDRecommendationSectionHeaderView"];
    if (section == 0) {
        head.contentView.backgroundColor = [UIColor orangeColor];
    }else{
        head.contentView.backgroundColor = [UIColor yellowColor];
    }
    return head;
}

#pragma mark - 公有方法
#pragma mark - 私有方法

- (void)setUI {
    
    
    // 扫一扫
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"扫一扫" style:0 target:self action:@selector(scanfButtonClick)];
    self.navigationItem.leftBarButtonItem = item;
    
    
    // 初始化头部view
    LDRecommendationHeaderView *recommendationHeaderView = [LDRecommendationHeaderView recommendationHeaderView];
    recommendationHeaderView.ld_height = 160.0f;
    self.recommendationTableView.tableHeaderView = recommendationHeaderView;
    
   
    // 注册各种cell 和头部view
    [self.recommendationTableView registerNib:[UINib nibWithNibName:@"LDRecommendationOriginalityCell" bundle:nil] forCellReuseIdentifier:@"LDRecommendationOriginalityCell"];
    
    [self.recommendationTableView registerNib:[UINib nibWithNibName:@"LDRecommendationStoriesCell" bundle:nil] forCellReuseIdentifier:@"LDRecommendationStoriesCell"];
    
    [self.recommendationTableView registerClass:[LDRecommendationSectionHeaderView class] forHeaderFooterViewReuseIdentifier:@"LDRecommendationSectionHeaderView"];
    
    
    // 添加下拉和上拉刷新控件
    self.recommendationTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.recommendationTableView.header beginRefreshing];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.recommendationTableView.header endRefreshing];
        });
    }];
    
    self.recommendationTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.recommendationTableView.footer beginRefreshing];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.recommendationTableView.footer endRefreshing];
        });
    }];
}

- (void)startDownloadData {

    [SVProgressHUD showWithStatus:@"正在加载..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - 事件响应

- (void)scanfButtonClick {

    [SVProgressHUD showSuccessWithStatus:@"扫一扫"];
}
@end
