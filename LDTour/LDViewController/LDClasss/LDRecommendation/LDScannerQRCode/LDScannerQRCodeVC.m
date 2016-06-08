//
//  LDScannerQRCodeVC.m
//  LDTour
//
//  Created by Daredos on 16/6/4.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDScannerQRCodeVC.h"
#import "BMScannerQRCodeView.h"
#import "UIDevice+BMDevice.h"
#import "UIApplication+BMExtension.h"
#import "BMScannerItemView.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface LDScannerQRCodeVC ()

@property (strong, nonatomic) BMScannerQRCodeView *scannerQRCodeView;

@end

@implementation LDScannerQRCodeVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.scannerQRCodeView startRunning];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self.scannerQRCodeView stopRunning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫一扫";
    
    if (![UIDevice bm_haveCamera]) {
        
        [SVProgressHUD showInfoWithStatus:@"你的设备没有相机哦."];
        [self.navigationController popViewControllerAnimated:YES];
        return;
        
    }else if (![UIApplication bm_haveAlbumPower]) {
        
        [SVProgressHUD showInfoWithStatus:@"APP 没有相机权限哦，请到设置 -> 通用 -> 相机 中打开."];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    [self.view addSubview:self.scannerQRCodeView];

    [self.view addSubview:[BMScannerItemView ScannerItemViewWithFrame:CGRectMake(0, kScreenheight-60-64, kScreenwidth, 60) photo:^{
        
        DAAlertAction *c = [DAAlertAction actionWithTitle:@"打开" style:0 handler:^{
        }];
        DAAlertAction *cancel = [DAAlertAction actionWithTitle:@"取消" style:DAAlertActionStyleDestructive handler:^{
        }];
        
        [DAAlertController showAlertOfStyle:0 inViewController:self withTitle:@"确定打开相册" message:nil actions:@[c, cancel]];
        
    } turn:^{
        ;
    }]];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:0 target:self action:@selector(selectAlbumButtonClick)];
}

- (void)applicationWillResignActive:(NSNotification *)notification {
    
    [self.scannerQRCodeView stopRunning];
}
- (void)applicationDidBecomeActive:(NSNotification *)notification {
    
    [self.scannerQRCodeView startRunning];
}

- (void)selectAlbumButtonClick {

}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark - init
#pragma mark - 生命周期
#pragma mark - getters setters

- (BMScannerQRCodeView *)scannerQRCodeView {

    if (!_scannerQRCodeView) {
        _scannerQRCodeView = [BMScannerQRCodeView scannerQRCodeViewWithScanneActionBlock:^(NSString *scanneString) {
            
            NSString *lowercaseString = [scanneString lowercaseString];
            // 二维码是http https 开头,直接打开网页
            if (NSNotFound != [lowercaseString rangeOfString:@"http:"].location
                || NSNotFound != [lowercaseString rangeOfString:@"https:"].location) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:scanneString]];
            }else{
                [SVProgressHUD showInfoWithStatus:scanneString];
            }
            [self.navigationController popViewControllerAnimated:NO];
        }];
    }
    return _scannerQRCodeView;
}
#pragma mark - 系统delegate
#pragma mark - 自定义delegate
#pragma mark - 公有方法
#pragma mark - 私有方法
#pragma mark - 事件响应
@end
