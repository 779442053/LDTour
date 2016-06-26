//
//  BMPointScannerCodeView.m
//  CodeView
//
//  Created by Daredos on 16/6/26.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import "BMPointScannerCodeView.h"
#import <AVFoundation/AVFoundation.h>

#define __ScreenWidth__ ([[UIScreen mainScreen] bounds].size.width)
#define __ScreenHight__ ([[UIScreen mainScreen] bounds].size.height)

@interface BMPointScannerCodeView () <AVCaptureMetadataOutputObjectsDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;       // 标题 Label
@property (weak, nonatomic) IBOutlet UIImageView *linImageView; // 动画imageView

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scanfViewYLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scanfViewWLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scanfViewHLayout;

@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;

@property (copy, nonatomic) ScanneActionBlock scanneActionBlock;

@property (assign, nonatomic) CGRect scannerCodeViewFrame;

@end

@implementation BMPointScannerCodeView

#pragma mark -
#pragma mark - init
#pragma mark - 生命周期

- (void)dealloc {

    [self stopRunning];
}

#pragma mark - getters setters

- (void)setTitle:(NSString *)title {

    _title = title;
    self.titleLabel.text = title;
}
#pragma mark - 系统delegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count) {
        // 停止扫描
        [_session stopRunning];
        [_previewLayer removeFromSuperlayer];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        NSString *stringValue = metadataObject.stringValue;
        if (self.scanneActionBlock) {
            self.scanneActionBlock(stringValue);
        }
    }
}

#pragma mark - 自定义delegate
#pragma mark - 公有方法

+ (instancetype)pointScannerCodeViewFrame:(CGRect)frame
                     scannerCodeViewFrame:(CGRect)scannerCodeViewFrame
                        scanneActionBlock:(ScanneActionBlock)scanneActionBlock {
    
    // 检查设备是否有相机
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return nil;
    }
    // 检查app是否有相机权限
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        return nil;
    }
    
    BMPointScannerCodeView *pointScannerCodeView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
    pointScannerCodeView.autoresizingMask = UIViewAutoresizingNone;
    
    pointScannerCodeView.frame = frame;
    
    pointScannerCodeView.scannerCodeViewFrame = scannerCodeViewFrame;
    pointScannerCodeView.scanneActionBlock = scanneActionBlock;
    
    pointScannerCodeView.scanfViewYLayout.constant = scannerCodeViewFrame.origin.y;
    pointScannerCodeView.scanfViewWLayout.constant = scannerCodeViewFrame.size.width;
    pointScannerCodeView.scanfViewHLayout.constant = scannerCodeViewFrame.size.height;
    
    pointScannerCodeView.linImageView.contentMode  = UIViewContentModeScaleAspectFill;
    [pointScannerCodeView.linImageView.layer addAnimation:[pointScannerCodeView getAnim] forKey:nil];
    
    // 创建扫描
    [pointScannerCodeView creatScanning];
    
    return pointScannerCodeView;
}

- (void)startRunning {
    
    [self.session startRunning];
    [self.linImageView.layer removeAllAnimations];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.linImageView.layer addAnimation:[self getAnim] forKey:nil];
    });
}

- (void)stopRunning {
    
    [self.session stopRunning];
    [self.linImageView.layer removeAllAnimations];
}
#pragma mark - 私有方法

- (CABasicAnimation *)getAnim {
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position.y"];
    
    anim.duration = 1.3333f;
    
    anim.fromValue = @(0.0f);
    
    anim.toValue = @(self.scannerCodeViewFrame.size.height);
    
    anim.repeatCount = INT_MAX;
    
    anim.autoreverses = YES;
    
    anim.removedOnCompletion = YES;
    
    anim.fillMode = kCAFillModeForwards;
    
    return anim;
}

// 创建扫描
- (void)creatScanning
{
    // 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    // 创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    
    // 设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 初始化链接对象
    self.session = [[AVCaptureSession alloc] init];
    
    double w = __ScreenWidth__;
    double h = __ScreenHight__;
    double x = (__ScreenWidth__-self.scannerCodeViewFrame.size.width)/2.0;
    
    //  扫描区域view的y/屏幕高  扫描区域view的x/屏幕宽  扫描区域view的h/屏幕高   扫描区域view的w/屏幕宽
    [output setRectOfInterest:CGRectMake((self.scannerCodeViewFrame.origin.y)/h,x/w,self.scannerCodeViewFrame.size.height/h,self.scannerCodeViewFrame.size.width/w)];
    
    // 高质量采集率
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [self.session addInput:input];
    
    [self.session addOutput:output];
    
    // 设置扫码支持的编码格式
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResize;
    
    // 必须添加
    self.previewLayer.frame = [self screenBounds];
    
    self.previewLayer.connection.videoOrientation = [self videoOrientationFromCurrentDeviceOrientation];
    
    [self.layer insertSublayer:self.previewLayer atIndex:0];
    
    //开始捕获
    [self.session startRunning];
}

- (CGRect)screenBounds {
    
    UIScreen *screen = [UIScreen mainScreen];
    CGRect screenRect;
    if (![screen respondsToSelector:@selector(fixedCoordinateSpace)] && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        screenRect = CGRectMake(0, 0, screen.bounds.size.height, screen.bounds.size.width);
    } else {
        screenRect = screen.bounds;
    }
    return screenRect;
}

- (AVCaptureVideoOrientation)videoOrientationFromCurrentDeviceOrientation {
    
    switch ([[UIApplication sharedApplication] statusBarOrientation]) {
            
        case UIInterfaceOrientationPortrait:
            return AVCaptureVideoOrientationPortrait;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            return AVCaptureVideoOrientationLandscapeLeft;
            break;
        case UIInterfaceOrientationLandscapeRight:
            return AVCaptureVideoOrientationLandscapeRight;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            return AVCaptureVideoOrientationPortraitUpsideDown;
            break;
        default:
            break;
    }
    return AVCaptureVideoOrientationPortrait;
}

#pragma mark - 事件响应

@end
