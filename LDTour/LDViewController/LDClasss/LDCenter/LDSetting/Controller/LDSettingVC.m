//
//  LDSettingVC.m
//  LDTour
//
//  Created by Daredos on 16/6/4.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDSettingVC.h"

@interface LDSettingVC () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *settingArray;
@property (weak, nonatomic) IBOutlet UITableView *settingTableView;

@end

@implementation LDSettingVC

#pragma mark -
#pragma mark - init
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingArray];
    
    [self.settingTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

#pragma mark - getters setters

- (NSMutableArray *)settingArray {

    if (!_settingArray) {
        
        _settingArray = [@[] mutableCopy];
        
        int sec = arc4random()%5+4;
        int s = 0;
        while (s++ < sec) {
            int r = 0;
            int row = arc4random()%6+3;
            if (s == 1) {
                row = 1;
            }
            NSMutableArray *muarr = [@[] mutableCopy];
            while (r++ < row) {
                [muarr addObject:[NSString stringWithFormat:@"第%d组（第%d行设置）",s,r]];
            }
            [_settingArray addObject:muarr];
        }
    }
    return _settingArray;
}

#pragma mark - 系统delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.settingArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.settingArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    NSString *string = self.settingArray[indexPath.section][indexPath.row];
    cell.textLabel.text = string;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.000001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 100;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *string = self.settingArray[indexPath.section][indexPath.row];
    [SVProgressHUD showSuccessWithStatus:string];
}

#pragma mark - 自定义delegate
#pragma mark - 公有方法
#pragma mark - 私有方法
#pragma mark - 事件响应
@end
