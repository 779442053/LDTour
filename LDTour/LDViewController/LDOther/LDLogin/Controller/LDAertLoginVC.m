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
#import "UIApplication+BMExtension.h"
#import "LDRegisterVC.h"
#import "LDForgetVC.h"


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
    self.view.backgroundColor = [UIColor colorWithRed:73/255.0 green:189/255.0 blue:206/255.0 alpha:1];
    self.loginButton.backgroundColor = [UIColor grayColor];
    self.loginButton.userInteractionEnabled = NO;
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
    
    [self presentViewController:[LDForgetVC new] animated:YES completion:Nil];

}

- (IBAction)registerButtonClick:(id)sender {
    
    [self presentViewController:[LDRegisterVC new] animated:YES completion:nil];
}

+ (void)alertLoginVC {
    
    LDAertLoginVC *c = [LDAertLoginVC new];
    [[UIApplication bm_topViewController] presentViewController:c animated:YES completion:nil];
}


- (IBAction)usertextfiledChangedClick:(id)sender {
    
    if (self.userTextfiled.text.length && self.passwordTextfiled.text.length) {
        
        self.loginButton.backgroundColor = [UIColor orangeColor];
        self.loginButton.userInteractionEnabled = YES;
    }else {
        
        self.loginButton.backgroundColor = [UIColor grayColor];
        self.loginButton.userInteractionEnabled = NO;
    }
}

- (IBAction)passwordtextfiledChangedClick:(id)sender {
    
    if (self.userTextfiled.text.length && self.passwordTextfiled.text.length) {
        
        self.loginButton.backgroundColor = [UIColor orangeColor];
        self.loginButton.userInteractionEnabled = YES;
    }else {
        
        self.loginButton.backgroundColor = [UIColor grayColor];
        self.loginButton.userInteractionEnabled = NO;
    }
}
@end
