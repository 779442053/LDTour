//
//  BMDatePickView.h
//  BMDatePickViewDemo
//
//  Created by Daredos on 16/6/15.
//  Copyright © 2016年 Daredos. All rights reserved.
//

/*!
 github: https://github.com/asiosldh
 */

#import <UIKit/UIKit.h>

typedef void(^BMChangeDateBlock)(NSDate *selectDate);

/*!
 *  @brief 弹窗类型
 */
typedef NS_ENUM(NSInteger, BMDatePickerMode) {
    /*!
     *  只有 年
     */
    BMDatePickerModeYear = 0,
    /*!
     *  只有 年月
     */
    BMDatePickerModeYearMon,
    /*!
     *  只有 年月日
     */
    BMDatePickerModeYearMonday,
    /*!
     *  只有 年月日时
     */
    BMDatePickerModeYearMondayH,
    /*!
     *  只有 年月日 时分
     */
    BMDatePickerModeYearMondayHM,
    /*!
     *  只有 年月日 时分秒
     */
    BMDatePickerModeYearMondayHMS,
};

/*!
 *  @brief 模仿系统 datePick
 */
@interface BMDatePickView : UIView

/*!
 *  @brief 类型
 */
@property (assign, nonatomic) BMDatePickerMode datePickerMode;

/*!
 *  @brief 显示的时间
 */
@property (strong, nonatomic) NSDate *date;

/*!
 *  @brief 最大时间
 */
@property (strong, nonatomic) NSDate *maximumDate;

/*!
 *  @brief 最小时间
 */
@property (strong, nonatomic) NSDate *minimumDate;

/*!
 *  @brief 变化时间的回调block
 */
@property (copy, nonatomic)   BMChangeDateBlock changeDateBlock;

+ (instancetype)new   UNAVAILABLE_ATTRIBUTE;
- (instancetype)init  UNAVAILABLE_ATTRIBUTE;

/*!
 *  @brief 创建时间选择器
 *
 *  @param currentDate     默认显示的时间
 *  @param changeDateBlock 变化时间的回调block
 */
+ (instancetype)datePickViewWithDate:(NSDate *)date changeDateBlock:(BMChangeDateBlock)changeDateBlock;

/*!
 *  @brief 显示时间选择器
 */
- (void)show;

@end
