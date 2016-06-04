//
//  BMScannerQRCodeView.h
//  BMQRCode
//
//  Created by 1 on 16/3/1.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ScanneActionBlock)(NSString *scanneString);

/**
 *  本 类主要服务于项目: 默认创建一个 200X200 区域的扫描界面
 */
@interface BMScannerQRCodeView : UIView
/**
 *  扫描到内容的回调
 */
@property (copy, nonatomic) ScanneActionBlock scanneActionBlock;

/**
 *  创建 二维码扫描界面
 *
 *  @param scanneActionBlock 扫描到内容的回调
 *
 *  @return 创建的view
 */
+ (instancetype)scannerQRCodeViewWithScanneActionBlock:(ScanneActionBlock)scanneActionBlock;


- (void)startRunning;

- (void)stopRunning;

@end
