//
//  LDStartViewController.m
//  LDTour
//
//  Created by Daredos on 16/5/25.
//  Copyright © 2016年 LiangDaHong. All rights reserved.
//

#import "LDStartViewController.h"
#import <ImageIO/ImageIO.h>

@interface LDStartViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *anImageView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) NSTimer *autoTime;
@property (assign, nonatomic) BOOL sel;
@property (assign, nonatomic) int time;

@end

@implementation LDStartViewController

#pragma mark -
#pragma mark - init
#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.button.layer.cornerRadius = 4.0f;
    self.button.clipsToBounds = YES;
    self.button.layer.borderColor = [UIColor grayColor].CGColor;
    self.button.layer.borderWidth = 1.0;
    [self.button setTitleColor:[UIColor grayColor] forState:0];
    
    self.time = self.timingTime;
    NSString *string = [NSString stringWithFormat:@" %d秒 跳过广告",(int)self.time];
    [self.button setTitle:string forState:0];
    
    func_path(self.anImageView.layer,(int)self.time);
    
    _autoTime = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(autoTimeClick) userInfo:nil repeats:YES];
    self.time--;
    
    NSString  *name = self.gifName;
    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:name ofType:nil];
    NSData  *imageData = [NSData dataWithContentsOfFile:filePath];

    self.imageView.image  = [self animatedGIFWithData:imageData];
}

#pragma mark - getters setters
#pragma mark - 系统delegate
#pragma mark - 自定义delegate
#pragma mark - 公有方法

+ (instancetype)startViewControllerWithGifName:(NSString *)gifName timingTime:(int)timingTime endBlock:(dispatch_block_t)endBlock {
    
    LDStartViewController *c = [LDStartViewController new];
    c.gifName = gifName;
    c.timingTime = timingTime;
    c.endBlock = endBlock;
    return c;
}

#pragma mark - 私有方法

- (void)autoTimeClick {
    
    if (self.time <= 0) {
        [_autoTime invalidate];
        _autoTime = nil;
        if (!self.sel && self.endBlock) {
            
            [UIView animateWithDuration:0.3 animations:^{
                
                self.view.alpha = 0.0f;
            } completion:^(BOOL finished) {
                
                self.endBlock();
            }];
        }
    }else{
        NSString *string = [NSString stringWithFormat:@" %2.d秒 跳过广告",(int)self.time];
        self.time--;
        [self.button setTitle:string forState:0];
    }
}

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

- (UIImage *)animatedGIFWithData:(NSData *)data {
    
    if (!data) {
        return nil;
    }
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    size_t count = CGImageSourceGetCount(source);
    
    UIImage *animatedImage;
    
    if (count <= 1) {
        
        animatedImage = [[UIImage alloc] initWithData:data];
    }
    else {
        NSMutableArray *images = [NSMutableArray array];
        
        NSTimeInterval duration = 0.0f;
        
        for (size_t i = 0; i < count; i++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            
            duration += [self frameDurationAtIndex:i source:source];
            
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            
            CGImageRelease(image);
        }
        
        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
        
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    
    CFRelease(source);
    
    return animatedImage;
}

- (float)frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }
    else {
        
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    CFRelease(cfFrameProperties);
    return frameDuration;
}

#pragma mark - 事件响应

- (IBAction)skipButtonClick:(id)sender {

    self.sel = YES;
    [_autoTime invalidate];
    _autoTime = nil;
    if (self.endBlock) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.alpha = 0.0f;
        } completion:^(BOOL finished) {
            self.endBlock();
        }];
    }
}


void func_path(CALayer *layer, int sec) {
    
    CGRect boundingRect = CGRectMake(-160, -160, 320, 320);
    
    CAKeyframeAnimation *orbit= [CAKeyframeAnimation animation];
    
    orbit.keyPath = @"position";
    
    orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect,NULL));
    
    orbit.duration = sec;
    
    orbit.additive = YES;
    
    orbit.repeatCount = 2;
    
    orbit.calculationMode = kCAAnimationPaced;
    
    orbit.rotationMode = kCAAnimationRotateAuto;
    
    orbit.timingFunction =  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // orbit.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5 :0 :0.5 :1];
    
    [layer addAnimation:orbit forKey:nil];
}

@end
