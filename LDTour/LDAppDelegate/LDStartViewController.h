//
//  LDStartViewController.h
//  LDTour
//
//  Created by Daredos on 16/5/25.
//  Copyright © 2016年 LiangDaHong. All rights reserved.
//  github：


#import <UIKit/UIKit.h>

@interface LDStartViewController : UIViewController

/*!
 *  @brief gif 图片名称
 */
@property (copy, nonatomic) NSString *gifName;

/*!
 *  @brief 结束block
 */
@property (copy, nonatomic) dispatch_block_t endBlock;

/*!
 *  @brief 倒计时时间 （秒）
 */
@property (assign, nonatomic) int timingTime;

/*!
 *  @brief 创建启动动画控制器
 *
 *  @param gifName    gif 图片名称
 *  @param timingTime 倒计时时间
 *  @param endBlock   结束block
 */
+ (instancetype)startViewControllerWithGifName:(NSString *)gifName timingTime:(int)timingTime endBlock:(dispatch_block_t)endBlock;

@end
