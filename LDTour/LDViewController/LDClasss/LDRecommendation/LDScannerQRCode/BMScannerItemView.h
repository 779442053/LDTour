//
//  BMScannerItemView.h
//  LDTour
//
//  Created by Daredos on 16/6/8.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMScannerItemView : UIView

+ (instancetype)ScannerItemViewWithFrame:(CGRect)frame photo:(dispatch_block_t)photoBlock turn:(dispatch_block_t )turnBlock;

@end
