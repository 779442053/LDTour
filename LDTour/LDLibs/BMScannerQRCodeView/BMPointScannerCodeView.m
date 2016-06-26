//
//  BMPointScannerCodeView.m
//  LDTour
//
//  Created by Daredos on 16/6/26.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "BMPointScannerCodeView.h"
#define kScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define kScreenHight ([[UIScreen mainScreen] bounds].size.height)

@interface BMPointScannerCodeView ()

//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scanfViewXLayout;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scanfViewYLayout;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scanfViewWLayout;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scanfViewHLayout;

@end

@implementation BMPointScannerCodeView

+ (instancetype)pointScannerCodeViewScannerCodeViewFrame:(CGRect)frame {
    
    BMPointScannerCodeView *pointScannerCodeView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
    pointScannerCodeView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHight);
//    pointScannerCodeView.scanfViewXLayout.constant = frame.origin.x;
//    pointScannerCodeView.scanfViewYLayout.constant = frame.origin.y;
//    pointScannerCodeView.scanfViewWLayout.constant = frame.size.width;
//    pointScannerCodeView.scanfViewHLayout.constant = frame.size.height;
    return pointScannerCodeView;
}


@end
