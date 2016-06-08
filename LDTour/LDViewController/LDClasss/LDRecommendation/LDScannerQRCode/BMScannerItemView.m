//
//  BMScannerItemView.m
//  LDTour
//
//  Created by Daredos on 16/6/8.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "BMScannerItemView.h"

@interface BMScannerItemView ()

@property (copy, nonatomic) dispatch_block_t photoBlock;
@property (copy, nonatomic) dispatch_block_t turnBlock;

@end

@implementation BMScannerItemView

- (void)drawRect:(CGRect)rect {
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
}

+ (instancetype)ScannerItemViewWithFrame:(CGRect)frame photo:(dispatch_block_t)photoBlock turn:(dispatch_block_t )turnBlock {

    BMScannerItemView *scannerItemView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
    scannerItemView.frame = frame;
    scannerItemView.photoBlock = photoBlock;
    scannerItemView.turnBlock = turnBlock;
    return scannerItemView;
}
@end
