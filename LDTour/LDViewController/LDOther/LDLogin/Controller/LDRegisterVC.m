//
//  LDRegisterVC.m
//  LDTour
//
//  Created by Daredos on 16/6/6.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDRegisterVC.h"
#import "LDHHTTPSessionManager.h"

@interface LDRegisterVC ()

@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextfiled;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfiled;
@end

@implementation LDRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.registerButton.backgroundColor = [UIColor grayColor];
    self.registerButton.userInteractionEnabled = NO;
}


- (IBAction)registerButtonClick:(id)sender {

    [LDHHTTPSessionManager registerWithNetIdentifier:@"register" userName:self.userNameTextfiled.text password:self.passwordTextfiled.text downloadProgressBlock:nil successBlock:^(id responseObject) {
        [self.navigationController  popToRootViewControllerAnimated:YES];
        [SVProgressHUD showSuccessWithStatus:@"注册成功!"];
    } failureBlock:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:error.domain];
    }];
}


- (IBAction)usertextfiledChangedClick:(id)sender {
    
    if (self.userNameTextfiled.text.length && self.passwordTextfiled.text.length) {
        
        self.registerButton.backgroundColor = [UIColor orangeColor];
        self.registerButton.userInteractionEnabled = YES;
    }else {
        
        self.registerButton.backgroundColor = [UIColor grayColor];
        self.registerButton.userInteractionEnabled = NO;
    }
}

- (IBAction)passwordtextfiledChangedClick:(id)sender {
    
    if (self.userNameTextfiled.text.length && self.passwordTextfiled.text.length) {
        
        self.registerButton.backgroundColor = [UIColor orangeColor];
        self.registerButton.userInteractionEnabled = YES;
    }else {
        
        self.registerButton.backgroundColor = [UIColor grayColor];
        self.registerButton.userInteractionEnabled = NO;
    }
}
@end
