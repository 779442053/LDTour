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
    
    [self dismissViewControllerAnimated:YES completion:^{
        LDAPPCacheManager *cacheManager = [LDAPPCacheManager sharedAPPCacheManager];
        [cacheManager loginSituation:YES];
    }];
}


@end
