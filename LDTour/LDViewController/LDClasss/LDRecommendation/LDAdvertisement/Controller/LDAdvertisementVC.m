//
//  LDAdvertisementVC.m
//  LDTour
//
//  Created by Daredos on 16/6/4.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDAdvertisementVC.h"
#import "MJRefresh.h"

@interface LDAdvertisementVC () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation LDAdvertisementVC

- (void)dealloc {
    
    self.webView.delegate = nil;
    [self.webView stopLoading];
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"LDAdvertisement";
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: arc4random()%2 == 0 ? @"http://www.cnblogs.com/dahongliang/" : @"https://github.com/asiosldh"]]];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"<< back" style:0 target:self action:@selector(backClock)];
    self.navigationItem.leftBarButtonItem = item;
    
    self.webView.scrollView.backgroundColor = [UIColor whiteColor];
    self.webView.scalesPageToFit = YES;
    
    // 添加下拉和上拉刷新控件
    self.webView.scrollView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.webView.scrollView.header beginRefreshing];
        [self.webView reload];
    }];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [SVProgressHUD showWithStatus:@"正在加载..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
    [self.webView.scrollView.header endRefreshing];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    [SVProgressHUD showErrorWithStatus:error.domain];
    [self.webView.scrollView.header endRefreshing];
}

- (void)backClock {
    
    if (self.webView.canGoBack ) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
