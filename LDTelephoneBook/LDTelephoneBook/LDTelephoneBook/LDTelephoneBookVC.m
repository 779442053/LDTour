//
//  LDTelephoneBookVC.m
//  LDTelephoneBook
//
//  Created by Daredos on 16/6/30.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDTelephoneBookVC.h"
#import "LDTelephoneBookDateVC.h"
#import "LDTelephoneBookAddVC.h"
#import "LDTelephoneBookManger.h"

@interface LDTelephoneBookVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *telephoneBookTableView;

@end

@implementation LDTelephoneBookVC

#pragma mark -
#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self.telephoneBookTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通讯录";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItemClick)];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editItemClick)];
}

#pragma mark - getters setters

#pragma mark - 系统delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSString *title = [NSString stringWithFormat:@"%ld 联系人",[LDTelephoneBookManger sharedTelephoneBookManger].telephoneBookArray.count];
    self.title = title;
    return [LDTelephoneBookManger sharedTelephoneBookManger].telephoneBookArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:ID];
    }
    cell.textLabel.text = [LDTelephoneBookManger sharedTelephoneBookManger].telephoneBookArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LDTelephoneBookDateVC *c = [LDTelephoneBookDateVC new];
    c.title = [NSString stringWithFormat:@"%ld",indexPath.row];
    [self.navigationController pushViewController:c animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {

    NSMutableArray *muarray = [@[] mutableCopy];
    [muarray addObject:@"#"];

    char c = 'A';
    while (c < 'Z' + 1) {
        [muarray addObject:[NSString stringWithFormat:@"%c",c]];
        c ++;
    }
    return muarray;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull index) {
        if ([[LDTelephoneBookManger sharedTelephoneBookManger] removeTelephoneWithName:nil phone:[LDTelephoneBookManger sharedTelephoneBookManger].telephoneBookArray[index.row]]) {
            [self.telephoneBookTableView deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationTop];
        }
    }];
    return @[action];
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (arc4random()%2 == 0) {
        return UITableViewCellEditingStyleInsert;
    }
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int count = 1;

    NSArray *headArray = @[@"159",@"158",@"139",@"137",@"132"];
    
    while (count--) {
        
        BOOL sel = YES;
        
        while (sel) {
            int arc = arc4random_uniform(5);
            NSInteger num = arc4random_uniform(99999999)+10000000;
            NSString *str = [NSString stringWithFormat:@"%@%ld",headArray[arc],num];
            BOOL sel1 = [[LDTelephoneBookManger sharedTelephoneBookManger] addTelephoneWithName:nil phone:str];
            if (sel1) {
                sel = NO;
            }
        }
    }
    [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:0];
}
#pragma mark - 自定义delegate
#pragma mark - 公有方法
#pragma mark - 私有方法
#pragma mark - 事件响应

- (void)addItemClick {
    
    LDTelephoneBookAddVC *c = [LDTelephoneBookAddVC new];
    [self.navigationController pushViewController:c animated:YES];
}

- (void)editItemClick {

    BOOL sel =  self.telephoneBookTableView.editing ? NO : YES;

    [self.telephoneBookTableView setEditing:sel animated:YES];
}

@end
