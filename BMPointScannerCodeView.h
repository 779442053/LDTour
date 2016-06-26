//
//  BMPointScannerCodeView.h
//  CodeView
//
//  Created by Daredos on 16/6/26.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 *  @brief 成功扫描到内容时的回调block
 *
 *  @param scanneString 扫描的内容
 */
typedef void(^ScanneActionBlock)(NSString *scanneString);

/*!
 *  @brief 扫描view
 */
@interface BMPointScannerCodeView : UIView

/*!
 *  @brief 标题
 */
@property (copy, nonatomic) NSString *title;

/*!
*  @brief 创建扫描view
*
*  @param frame             frame
*  @param frame             扫描区域的frame
*  @param scanneActionBlock 成功回调block
*/
+ (instancetype)pointScannerCodeViewFrame:(CGRect)frame
                     scannerCodeViewFrame:(CGRect)frame
                        scanneActionBlock:(ScanneActionBlock)scanneActionBlock;

/*!
 *  @brief 开始扫描
 */
- (void)startRunning;

/*!
 *  @brief 停止扫描
 */
- (void)stopRunning;

@end
