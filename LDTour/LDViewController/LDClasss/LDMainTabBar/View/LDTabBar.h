//
//  LDTabBar.h
//  LDTour
//
//  Created by Daredos on 16/5/24.
//  Copyright © 2016年 LiangDaHong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BMSelectControllerActionBlock)(NSInteger selectIndex);

/*!
 *  @brief 自定义的tabBar
 */
@interface LDTabBar : UITabBar

/*!
 *  @brief 选择控制器的回调block
 */
@property (copy, nonatomic) BMSelectControllerActionBlock selectControllerActionBlock;

/*!
 *  @brief 点击中间按钮的回调block
 */
@property (copy, nonatomic) dispatch_block_t tapCenterBlock;

/*!
 *  @brief 创建tabBar
 */
+ (instancetype)tabBar;

/*!
 *  @brief 创建TabBar
 *
 *  @param selectControllerActionBlock 选择控制器的回调block
 *  @param tapCenterBlock              点击中间按钮的回调block
 */
+ (instancetype)tabBarWithSelectControllerActionBlock:(BMSelectControllerActionBlock)selectControllerActionBlock
                                       tapCenterBlock:(dispatch_block_t)tapCenterBlock;

@end
