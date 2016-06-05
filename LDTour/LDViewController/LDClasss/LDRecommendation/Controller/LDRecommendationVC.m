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
#import "SDCycleScrollView.h"
#import "LDAdvertisementVC.h"
#import "LDHHTTPSessionManager.h"
#import "LDScannerQRCodeVC.h"

@interface LDRecommendationVC () <UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *recommendationTableView;
@property (strong, nonatomic) SDCycleScrollView *cycleScrollView;
@property (strong, nonatomic) NSMutableArray *recommendationArray;
@property (assign, nonatomic) int start;
@property (assign, nonatomic) int count;

@end

@implementation LDRecommendationVC

#pragma mark -
#pragma mark - init
#pragma mark - 生命周期

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setUI];
    
    _start = 0;
    _count = 10;
    [self startDownloadData];
    [self setartDownloadTableData];
}

#pragma mark - getters setters

- (NSMutableArray *)recommendationArray {

    if (!_recommendationArray) {
        _recommendationArray = [@[] mutableCopy];
    }
    return _recommendationArray;
}

#pragma mark - 系统delegate
#pragma mark - 自定义delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.recommendationArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LDRecommendationOriginalityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDRecommendationOriginalityCell"];
    cell.imageUrl = self.recommendationArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 5.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.000001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 200;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    LDRecommendationSectionHeaderView *head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LDRecommendationSectionHeaderView"];
    head.contentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    return head;
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    LDAdvertisementVC *c = [LDAdvertisementVC new];
    [self.navigationController pushViewController:c animated:YES];
}

#pragma mark - 公有方法
#pragma mark - 私有方法

- (void)setUI {
    
    // 扫一扫
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"扫一扫" style:0 target:self action:@selector(scanfButtonClick)];
    self.navigationItem.leftBarButtonItem = item;
    
    // 注册各种cell 和头部view
    [self.recommendationTableView registerNib:[UINib nibWithNibName:@"LDRecommendationOriginalityCell" bundle:nil] forCellReuseIdentifier:@"LDRecommendationOriginalityCell"];
    
    [self.recommendationTableView registerNib:[UINib nibWithNibName:@"LDRecommendationStoriesCell" bundle:nil] forCellReuseIdentifier:@"LDRecommendationStoriesCell"];
    
    [self.recommendationTableView registerClass:[LDRecommendationSectionHeaderView class] forHeaderFooterViewReuseIdentifier:@"LDRecommendationSectionHeaderView"];
    
    // 添加下拉和上拉刷新控件
    self.recommendationTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.start = 0;
        [self.recommendationTableView.header beginRefreshing];
        [self setartDownloadTableData];
    }];
    
    self.recommendationTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.start++;
        [self.recommendationTableView.footer beginRefreshing];
        [self setartDownloadTableData];
    }];
    self.recommendationTableView.tableHeaderView = self.cycleScrollView;
}

- (SDCycleScrollView *)cycleScrollView {

    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, 200, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    }
    return _cycleScrollView;
}

- (void)startDownloadData {
    
    [LDHHTTPSessionManager getAdvertisementDataWithNetIdentifier:@"getAdvertisementDataIdentifier" downloadProgressBlock:nil successBlock:^(id responseObject) {
        [self reloadAdvertisementUIWithData:responseObject];
    } failureBlock:^(NSError *error) {
    }];
}
- (void)setartDownloadTableData {
    
    [SVProgressHUD showWithStatus:@"正在加载..."];
    [LDHHTTPSessionManager getMenuTableDataWithNetIdentifier:@"setartDownloadTableData" start:self.start count:self.count downloadProgressBlock:nil successBlock:^(id responseObject) {
        [SVProgressHUD dismiss];
        [self.recommendationTableView.header endRefreshing];
        [self.recommendationTableView.footer endRefreshing];
        
        if (self.start == 0) {
            [self.recommendationArray removeAllObjects];
        }
        NSArray *array = responseObject[@"trips"];
        for (NSDictionary *dict in array) {
            [self.recommendationArray addObject:dict[@"cover_image"]];
        }
        [self.recommendationTableView reloadData];
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:error.domain];
        [self.recommendationTableView.header endRefreshing];
        [self.recommendationTableView.footer endRefreshing];
    }];
}

- (void)reloadAdvertisementUIWithData:(id)data {
    
    NSMutableArray *imagesURLStrings = [@[] mutableCopy];
    NSMutableArray *titles = [@[] mutableCopy];
    NSArray *array = data[@"data"][@"banners"];
    for (NSDictionary *dict in array) {
        [imagesURLStrings addObject:dict[@"image_url"]];
        [titles addObject:@"😊~~~~~~~"];
    }
    self.cycleScrollView.titlesGroup = titles;
    self.cycleScrollView.imageURLStringsGroup = imagesURLStrings;
}

#pragma mark - 事件响应

- (void)scanfButtonClick {
    
    [self.navigationController pushViewController:[LDScannerQRCodeVC new] animated:YES];
}
@end
