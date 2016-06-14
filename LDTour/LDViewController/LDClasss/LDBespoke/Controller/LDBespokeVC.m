//
//  LDBespokeVC.m
//  LDTour
//
//  Created by Daredos on 16/6/4.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDBespokeVC.h"
#import "LDBespokeDataVC.h"

@interface LDBespokeVC () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *bespokeArray;

@property (weak, nonatomic) IBOutlet UITableView *bespokeTableView;

@end

@implementation LDBespokeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD showWithStatus:@""];
    [LDHHTTPSessionManager getWxarticleCategoryWithNetIdentifier:@"getWXC" downloadProgressBlock:nil successBlock:^(id responseObject) {
        [SVProgressHUD dismiss];
        [self.bespokeArray addObjectsFromArray:responseObject];
        [self.bespokeTableView reloadData];
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:error.domain];
    }];
    [self.bespokeTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}


#pragma mark -
#pragma mark - init
#pragma mark - 生命周期
#pragma mark - getters setters
- (NSMutableArray *)bespokeArray {

    if (!_bespokeArray) {
        
        _bespokeArray = @[].mutableCopy;
    }
    return _bespokeArray;
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
    cell.textLabel.text = dict[@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    LDBespokeDataVC *c = [LDBespokeDataVC new];
    NSDictionary *dict = self.bespokeArray[indexPath.row];
    c.cid = dict[@"cid"];
    c.title = dict[@"name"];
    [self.navigationController pushViewController:c animated:YES];
}

@end
