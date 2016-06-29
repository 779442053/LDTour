//
//  TelephoneBookAddPersonVC.m
//  TelephoneBook
//
//  Created by Daredos on 16/6/29.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "TelephoneBookAddPersonVC.h"
#import "YYCache.h"

@interface TelephoneBookAddPersonVC ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@end

@implementation TelephoneBookAddPersonVC

#pragma mark -
#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveItemClick)];
}

#pragma mark - getters setters
#pragma mark - 系统delegate
#pragma mark - 自定义delegate
#pragma mark - 公有方法
#pragma mark - 私有方法
#pragma mark - 事件响应

- (void)saveItemClick {

    if (self.nameTextField.text.length && self.phoneTextField.text.length && self.phoneTextField.text.length == 11) {

        if ([self addOK]) {
            self.reloadBlock ? self.reloadBlock() : nil;
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"联系人重复了" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入完整的信息" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (BOOL)addOK {

    YYCache *yyCache = [[YYCache alloc] initWithName:@"TelephoneBookDB"];
    id a = [yyCache objectForKey:@"TelephoneBookArray"];

    NSArray *arr = a;
    NSMutableArray *muarray = [@[] mutableCopy];
    if (arr && [arr isKindOfClass:[NSArray class]] && arr.count) {
        [muarray addObjectsFromArray:arr];
    }

    for (NSDictionary *dict in muarray) {
        if ([dict[@"name"] isEqualToString:self.nameTextField.text] || [dict[@"phone"] isEqualToString:self.phoneTextField.text]) {
            return NO;
        }
    }

    NSMutableString *string = [NSMutableString stringWithString:self.phoneTextField.text];

    if (string.length > 3) {
        [string insertString:@"-" atIndex:3];
    }

    if (string.length > 9) {
        [string insertString:@"-" atIndex:8];
    }
    [muarray addObject:@{@"name":self.nameTextField.text, @"phone":string}];

    [yyCache setObject:muarray forKey:@"TelephoneBookArray"];
    return YES;
}

@end
