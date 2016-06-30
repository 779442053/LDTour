//
//  LDTelephoneBookAddVC.m
//  LDTelephoneBook
//
//  Created by Daredos on 16/6/30.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDTelephoneBookAddVC.h"
#import "LDTelephoneBookManger.h"

@interface LDTelephoneBookAddVC ()

@end

@implementation LDTelephoneBookAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增联系人";

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneItemClick)];
}

- (void)doneItemClick {

    if ([[LDTelephoneBookManger sharedTelephoneBookManger] telephoneBookArray].count > 1000) {
        return;
    }

    int count = 10;

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
    [self.navigationController popViewControllerAnimated:YES];
}

@end
