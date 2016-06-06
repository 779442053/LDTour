//
//  LDAertLoginVC.m
//  LDTour
//
//  Created by Daredos on 16/6/5.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDAertLoginVC.h"
#import "LDAPPCacheManager.h"
#import <MobAPI/MobAPI.h>

@interface LDAertLoginVC ()

@property (weak, nonatomic) IBOutlet UITextField *userTextfiled;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfiled;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LDAertLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginButton.backgroundColor = [UIColor grayColor];
    self.loginButton.userInteractionEnabled = NO;

}


- (IBAction)testChangedClick:(id)sender {
    if (self.userTextfiled.text.length && self.passwordTextfiled.text.length) {
        
        self.loginButton.backgroundColor = [UIColor orangeColor];
        self.loginButton.userInteractionEnabled = YES;
    }else {
        
        self.loginButton.backgroundColor = [UIColor grayColor];
        self.loginButton.userInteractionEnabled = NO;
    }
}

- (IBAction)cancelButtonClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginButtonClick {
    
    [SVProgressHUD showWithStatus:@"登录中..." maskType:2];
    [MobAPI sendRequest:[MOBAUserCenter userLoginRequestByUsername:self.userTextfiled.text password:self.passwordTextfiled.text] onResult:^(MOBAResponse *response) {
        if (response.error) {
            [SVProgressHUD showInfoWithStatus:response.error.userInfo[@"error_message"]];
        }else{
            LDAPPCacheManager *cacheManager = [LDAPPCacheManager sharedAPPCacheManager];
            [cacheManager loginSituation:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
            [SVProgressHUD dismiss];
        }
    }];
}
@end
