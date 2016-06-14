//
//  LDBespokeDataWebVC.m
//  LDTour
//
//  Created by Daredos on 16/6/14.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDBespokeDataWebVC.h"

@interface LDBespokeDataWebVC () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *bespokeDataWebView;

@end

@implementation LDBespokeDataWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD showWithStatus:@"正在加载..." maskType:2];
    
    
    [self.bespokeDataWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

#pragma mark - 系统delegate

- (void)webViewDidStartLoad:(UIWebView *)webView {

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    
    [SVProgressHUD showInfoWithStatus:error.domain];
}

#pragma mark - 自定义delegate
#pragma mark - 公有方法
#pragma mark - 私有方法

#pragma mark - 事件响应


@end
