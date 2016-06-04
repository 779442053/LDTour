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

@interface LDRecommendationVC () <UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate>

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
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.recommendationTableView.header endRefreshing];
        });
    }];
    
    // 情景二：采用网络图片实现
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
    // 情景三：图片配文字
    NSArray *titles = @[@"高仿面包类型",
                        @"感谢您的支持",
                        @"😊~~~~~~~~~~~~~",
                        @"asiosldh@163.com"
                        ];

    // 网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, 200, 120) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.titlesGroup = titles;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色

    self.recommendationTableView.tableHeaderView = cycleScrollView2;
    cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
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
