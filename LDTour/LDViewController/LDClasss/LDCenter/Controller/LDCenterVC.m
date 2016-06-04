//
//  LDCenterVC.m
//  LDTour
//
//  Created by Daredos on 16/6/4.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDCenterVC.h"
#import "LDSettingVC.h"
#import "LDSettingHeadView.h"

@interface LDCenterVC ()

@property (weak, nonatomic) IBOutlet UITableView *centerPersonTableView;

@end

@implementation LDCenterVC


#pragma mark -
#pragma mark - init
#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}
#pragma mark - getters setters
#pragma mark - 系统delegate
#pragma mark - 自定义delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    return cell;
}

#pragma mark - 公有方法
#pragma mark - 私有方法

- (void)setUI {
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:0 target:self action:@selector(settingButtonClick)];
    self.navigationItem.rightBarButtonItem = item;
    
    LDSettingHeadView *settingHeadView = [LDSettingHeadView settingHeadView];
    self.centerPersonTableView.tableHeaderView = settingHeadView;
    
    [self.centerPersonTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}


#pragma mark - 事件响应

- (void)settingButtonClick {
    
    [self.navigationController pushViewController:[LDSettingVC new] animated:YES];
}

@end
