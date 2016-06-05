//
//  BMScannerQRCodeView.m
//  BMQRCode
//
//  Created by 1 on 16/3/1.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#define kScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define kScreenHight ([[UIScreen mainScreen] bounds].size.height)

#define kBit64Color(rgbValue)   [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0   \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0       \
blue:((float)(rgbValue & 0xFF))/255.0                 \
alpha:1.0]

#define kBit64ColorAlpha(rgbValue,al)   [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0   \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0       \
blue:((float)(rgbValue & 0xFF))/255.0                 \
alpha:al]

#import "BMScannerQRCodeView.h"
#import <AVFoundation/AVFoundation.h>


@interface BMScannerQRCodeView () <AVCaptureMetadataOutputObjectsDelegate>
@property (strong, nonatomic) AVCaptureSession *session;

@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;

@property (strong, nonatomic) UIImageView *qrLine;

@end

@implementation BMScannerQRCodeView

+ (instancetype)scannerQRCodeViewWithScanneActionBlock:(ScanneActionBlock)scanneActionBlock
{
    BMScannerQRCodeView *scannerQRCodeView = [[BMScannerQRCodeView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHight-64)];
    
    // 检查设备是否有相机
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return nil;
    }
    // 检查app是否有相机权限
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        return nil;
    }
    
    scannerQRCodeView.scanneActionBlock = scanneActionBlock;
    
    [scannerQRCodeView creatUI];
    
    [scannerQRCodeView creatScanning];
    
    return scannerQRCodeView;
}

- (void)creatUI
{
    double x = (kScreenWidth-200)/2.0;
    double y = (kScreenHight-64-200)/2.0;
    
    double w = 200.0;
    double h = 200.0;

    // 上 下 左 右
    [self addQRBackgroundViewWithFrame:CGRectMake(0, 0, kScreenWidth, y)];
    [self addQRBackgroundViewWithFrame:CGRectMake(0, y+h, kScreenWidth,(kScreenHight-200)/2.0+200)];
    
    [self addQRBackgroundViewWithFrame:CGRectMake(0, y,(kScreenWidth-200)/2.0, h)];
    [self addQRBackgroundViewWithFrame:CGRectMake((kScreenWidth-200)/2.0+200, y, (kScreenWidth-200)/2.0, h)];

    // 4个 L
    [self addQRIconWithFrame:CGRectMake(x, y, 30, 30)               imageName:@"image_qr_corner_001_"];
    [self addQRIconWithFrame:CGRectMake(x+w-30, y, 30, 30)          imageName:@"image_qr_corner_002_"];
    [self addQRIconWithFrame:CGRectMake(x, y+h-30, 30, 30)          imageName:@"image_qr_corner_003_"];
    [self addQRIconWithFrame:CGRectMake(x+w-30, y+h-30, 30, 30)     imageName:@"image_qr_corner_004_"];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, y-30, kScreenWidth, 20)];
    titleLabel.text = @"请将二维码置于取景框内";
    titleLabel.textAlignment = 1;
    [self addSubview:titleLabel];
    
    
    // 定时器
    _qrLine = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, 200, 2)];
    _qrLine.image = [UIImage imageNamed:@"image_qr_scan_line_001"];
    _qrLine.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_qrLine];
    [_qrLine.layer addAnimation:[self getAnim] forKey:nil];
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
    
    double w = kScreenWidth;
    double h = kScreenHight;
    
    double y = (kScreenHight-64.0-200.0)/2.0;
    double x = (kScreenWidth-200.0)/2.0;
    
    //  扫描区域view的y/屏幕高  扫描区域view的x/屏幕宽  扫描区域view的h/屏幕高   扫描区域view的w/屏幕宽
    [output setRectOfInterest:CGRectMake(y/h,x/w,200/h,200/w)];
    
    // 高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [_session addInput:input];
    
    [_session addOutput:output];
    
    // 设置扫码支持的编码格式
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    

    _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _previewLayer.videoGravity = AVLayerVideoGravityResize;
    
    // 必须添加
    _previewLayer.frame = [self screenBounds];
    
    _previewLayer.connection.videoOrientation = [self videoOrientationFromCurrentDeviceOrientation];
    
    [self.layer insertSublayer:_previewLayer atIndex:0];
    
    //开始捕获
    [_session startRunning];
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
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait)                return AVCaptureVideoOrientationPortrait;
    else if (orientation == UIInterfaceOrientationLandscapeLeft)      return AVCaptureVideoOrientationLandscapeLeft;
    else if (orientation == UIInterfaceOrientationLandscapeRight)     return AVCaptureVideoOrientationLandscapeRight;
    else if (orientation == UIInterfaceOrientationPortraitUpsideDown) return AVCaptureVideoOrientationPortraitUpsideDown;
    return AVCaptureVideoOrientationPortrait;
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if ([metadataObjects count] > 0 ) {
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

- (void)addQRIconWithFrame:(CGRect)frame imageName:(NSString *)imageName
{
    UIImageView *image = [[UIImageView alloc] initWithFrame:frame];
    image.image = [UIImage imageNamed:imageName];
    [self addSubview:image];
}

- (void)addQRBackgroundViewWithFrame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.3];
    [self addSubview:view];
}


- (void)startRunning {
    
    [self.session startRunning];
    [self.qrLine.layer removeAllAnimations];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.qrLine.layer addAnimation:[self getAnim] forKey:nil];
    });
}

- (void)stopRunning {
    
    [self.session stopRunning];
    [self.qrLine.layer removeAllAnimations];
}

- (CABasicAnimation *)getAnim {
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
    
    anim.duration = 1.3f;
    
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth/2.0f, (kScreenHight-64-200)/2.0f)];
    
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth/2.0f, (kScreenHight-64-200)/2.0f+200.0f)];
    anim.repeatCount = INT_MAX;
    
    anim.autoreverses = YES;
    
    anim.removedOnCompletion = YES;
    
    anim.fillMode = kCAFillModeForwards;
    
    return anim;
}

@end
