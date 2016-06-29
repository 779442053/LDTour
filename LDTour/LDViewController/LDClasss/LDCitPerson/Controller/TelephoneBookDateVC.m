//
//  TelephoneBookDateVC.m
//  TelephoneBook
//
//  Created by Daredos on 16/6/29.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "TelephoneBookDateVC.h"
#import "YYCache.h"

@interface TelephoneBookDateVC () <UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end

@implementation TelephoneBookDateVC

#pragma mark -
#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelItemClick)];
    self.nameLabel.text = self.dict[@"name"];
    self.phoneLabel.text = self.dict[@"phone"];
}

#pragma mark - getters setters
#pragma mark - 系统delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex == 0) {
        
        YYCache *yyCache = [[YYCache alloc] initWithName:@"TelephoneBookDB"];
        
        id a = [yyCache objectForKey:@"TelephoneBookArray"];
        
        NSArray *arr = a;
        
        __block NSMutableArray *muarray = [@[] mutableCopy];
        
        if (arr && [arr isKindOfClass:[NSArray class]] && arr.count) {
            [muarray addObjectsFromArray:arr];
        }
        
        [muarray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj[@"name"] isEqualToString:self.dict[@"name"]] && [obj[@"phone"] isEqualToString:self.dict[@"phone"]]) {
                [muarray removeObject:obj];
                *stop = YES;
                [yyCache setObject:muarray forKey:@"TelephoneBookArray"];
                self.reloadBlock ? self.reloadBlock() : nil;
            }
        }];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - 自定义delegate
#pragma mark - 公有方法
#pragma mark - 私有方法
#pragma mark - 事件响应
- (void)cancelItemClick {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"温馨提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定删除" otherButtonTitles:nil, nil];
    [sheet showInView:self.view];
}
@end
