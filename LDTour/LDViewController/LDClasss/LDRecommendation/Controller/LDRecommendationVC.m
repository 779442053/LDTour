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
    
    return 4;
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
        [self.recommendationTableView.header beginRefreshing];
        [self startDownloadData];
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
    
    [SVProgressHUD showWithStatus:@"正在加载..."];
    [LDHHTTPSessionManager getAdvertisementDataWithNetIdentifier:@"getAdvertisementDataIdentifier" downloadProgressBlock:nil successBlock:^(id responseObject) {
        [SVProgressHUD dismiss];
        [self.recommendationTableView.header endRefreshing];
        [self reloadAdvertisementUIWithData:responseObject];
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:error.domain];
        [self.recommendationTableView.header endRefreshing];
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
