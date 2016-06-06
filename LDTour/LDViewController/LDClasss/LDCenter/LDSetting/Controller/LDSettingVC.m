//
//  LDSettingVC.m
//  LDTour
//
//  Created by Daredos on 16/6/4.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDSettingVC.h"
#import "LDAPPCacheManager.h"
#import "DAAlertController.h"

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
        [_settingArray addObject:@[@"我是头像栏"]];
        [_settingArray addObject:@[@"添加朋友"]];
        [_settingArray addObject:@[@"修改账户密码",@"推送通知设置",@"链接社交网络",@"其他"]];
        [_settingArray addObject:@[@"清除缓存"]];

        [_settingArray addObject:@[@"关于我们",@"喜欢我，给我 5❤️吧",@"我有话说"]];
        [_settingArray addObject:@[@"精品应用推荐"]];
        [_settingArray addObject:@[@"退出登录"]];
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
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textAlignment = 0;
    cell.textLabel.textColor = [UIColor blackColor];

    if (indexPath.section == 6) {
        cell.textLabel.textAlignment = 1;
        cell.accessoryType = 0;
        cell.textLabel.textColor = [UIColor orangeColor];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 20.0f;
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
    
    if (indexPath.section+1 == self.settingArray.count) {
        
        DAAlertAction *a = [DAAlertAction actionWithTitle:@"确定" style:DAAlertActionStyleDestructive handler:^{
            LDAPPCacheManager *cacheManager = [LDAPPCacheManager sharedAPPCacheManager];
            [cacheManager loginSituation:NO];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        DAAlertAction *b = [DAAlertAction actionWithTitle:@"取消" style:DAAlertActionStyleCancel handler:nil];
        [DAAlertController showAlertOfStyle:DAAlertControllerStyleActionSheet inViewController:self withTitle:@"确定退出登录?" message:nil actions:@[a,b]];
        return;
    }
    
    NSString *string = self.settingArray[indexPath.section][indexPath.row];
    [SVProgressHUD showSuccessWithStatus:string];
}

#pragma mark - 自定义delegate
#pragma mark - 公有方法
#pragma mark - 私有方法
#pragma mark - 事件响应
@end
