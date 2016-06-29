//
//  LDCitPersonVC.m
//  LDTour
//
//  Created by Daredos on 16/6/4.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDCitPersonVC.h"
#import "TelephoneBookCell.h"
#import "TelephoneBookDateVC.h"
#import "TelephoneBookAddPersonVC.h"
#import "YYCache.h"

@interface LDCitPersonVC ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *telephoneBookTableView;
@property (strong, nonatomic) NSMutableArray *telephoneBookArray;

@end

@implementation LDCitPersonVC

#pragma mark -

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItemClick)];
 }

#pragma mark - getters setters

- (NSMutableArray *)telephoneBookArray {
    
    YYCache *yyCache = [[YYCache alloc] initWithName:@"TelephoneBookDB"];
    id a = [yyCache objectForKey:@"TelephoneBookArray"];
    NSArray *arr = a;
    if (arr && [arr isKindOfClass:[NSArray class]] && arr.count) {
        _telephoneBookArray = [arr mutableCopy];
    }else{
        _telephoneBookArray = [@[] mutableCopy];
    }
    return _telephoneBookArray;
}

#pragma mark - 系统delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.telephoneBookArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TelephoneBookCell *cell = [TelephoneBookCell telephoneBookCellWithTableView:tableView];
    
    cell.dict = self.telephoneBookArray[indexPath.row];
    
    cell.smsBlock = ^(NSString *string){
        NSString *str = [NSString stringWithFormat:@"sms://%@",string];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
    };
    cell.phoneBlock = ^(NSString *string){
        NSString *str = [NSString stringWithFormat:@"telprompt://%@",string];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.telephoneBookTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:0];
    
    TelephoneBookDateVC *c = [TelephoneBookDateVC new];
    c.dict = self.telephoneBookArray[indexPath.row];
    c.reloadBlock = ^{
        [self.telephoneBookTableView reloadData];
    };
    [self.navigationController pushViewController:c animated:YES];
}

#pragma mark - 自定义delegate
#pragma mark - 公有方法
#pragma mark - 私有方法
#pragma mark - 事件响应
- (void)addItemClick{
    
    TelephoneBookAddPersonVC *c = [TelephoneBookAddPersonVC new];
    c.reloadBlock = ^{
        [self.telephoneBookTableView reloadData];
    };
    [self.navigationController pushViewController:c animated:YES];
}
@end
