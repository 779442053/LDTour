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

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [SVProgressHUD showWithStatus:@"正在加载..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });

    LDRecommendationHeaderView *recommendationHeaderView = [LDRecommendationHeaderView recommendationHeaderView];
    recommendationHeaderView.ld_height = 160.0f;
    self.recommendationTableView.tableHeaderView = recommendationHeaderView;
    
    
    [self.recommendationTableView registerNib:[UINib nibWithNibName:@"LDRecommendationOriginalityCell" bundle:nil] forCellReuseIdentifier:@"LDRecommendationOriginalityCell"];
    
    [self.recommendationTableView registerNib:[UINib nibWithNibName:@"LDRecommendationStoriesCell" bundle:nil] forCellReuseIdentifier:@"LDRecommendationStoriesCell"];

    
    [self.recommendationTableView registerClass:[LDRecommendationSectionHeaderView class] forHeaderFooterViewReuseIdentifier:@"LDRecommendationSectionHeaderView"];
    
    
    
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
@end
