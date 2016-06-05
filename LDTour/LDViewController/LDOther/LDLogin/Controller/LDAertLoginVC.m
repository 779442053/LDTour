//
//  LDAertLoginVC.m
//  LDTour
//
//  Created by Daredos on 16/6/5.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDAertLoginVC.h"
#import "LDAPPCacheManager.h"

@interface LDAertLoginVC ()

@end

@implementation LDAertLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButtonClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginButtonClick {
    
    [SVProgressHUD showWithStatus:@"登录中..." maskType:2];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:@"登录成功!"];
        [self dismissViewControllerAnimated:YES completion:^{
            LDAPPCacheManager *cacheManager = [LDAPPCacheManager sharedAPPCacheManager];
            [cacheManager loginSituation:YES];
        }];
    });
}

@end
