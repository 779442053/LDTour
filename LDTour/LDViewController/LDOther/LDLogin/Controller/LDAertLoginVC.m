//
//  LDAertLoginVC.m
//  LDTour
//
//  Created by Daredos on 16/6/5.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDAertLoginVC.h"
#import "LDAPPCacheManager.h"
#import "LDHHTTPSessionManager.h"
#import "IQKeyboardManager.h"

@interface LDAertLoginVC ()

@property (weak, nonatomic) IBOutlet UITextField *userTextfiled;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfiled;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LDAertLoginVC

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
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
    
    [LDHHTTPSessionManager loginWithNetIdentifier:@"login" userName:self.userTextfiled.text password:self.passwordTextfiled.text downloadProgressBlock:nil successBlock:^(id responseObject) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [SVProgressHUD dismiss];
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:error.domain];
    }];
}

- (IBAction)tempLoginButtonClick:(id)sender {
    
    [SVProgressHUD showWithStatus:@"登录中..." maskType:2];
    [LDHHTTPSessionManager loginWithNetIdentifier:@"login" userName:@"123456" password:@"000000" downloadProgressBlock:nil successBlock:^(id responseObject) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [SVProgressHUD dismiss];
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:error.domain];
    }];
}
@end
