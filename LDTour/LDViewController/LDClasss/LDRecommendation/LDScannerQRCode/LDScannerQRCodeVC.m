//
//  LDScannerQRCodeVC.m
//  LDTour
//
//  Created by Daredos on 16/6/4.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDScannerQRCodeVC.h"
#import "BMPointScannerCodeView.h"

@interface LDScannerQRCodeVC ()

@property (strong, nonatomic) BMPointScannerCodeView *pointScannerCodeView;


@end

@implementation LDScannerQRCodeVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫一扫";
    
    [self.view addSubview:self.pointScannerCodeView];
}


- (BMPointScannerCodeView *)pointScannerCodeView {

    if (!_pointScannerCodeView) {
        _pointScannerCodeView = [BMPointScannerCodeView pointScannerCodeViewScannerCodeViewFrame:CGRectMake(30, 130, 200, 200)];
    }
    return _pointScannerCodeView;
}


#pragma mark -
#pragma mark - init
#pragma mark - 生命周期
#pragma mark - getters setters
#pragma mark - 系统delegate
#pragma mark - 自定义delegate
#pragma mark - 公有方法
#pragma mark - 私有方法
#pragma mark - 事件响应
@end
