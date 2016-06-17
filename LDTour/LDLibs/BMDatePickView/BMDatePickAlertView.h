//
//  BMDatePickAlertView.h
//  LDTour
//
//  Created by Daredos on 16/6/17.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BMDatePickAlertView;

typedef void(^ChangeBlock) (BMDatePickAlertView *datePickView, NSDate *date);
typedef void(^ConfirmBlock)(BMDatePickAlertView *datePickView, NSDate *date);

/*!
 *  @brief 自定义的时间选择控件类型
 */
typedef NS_ENUM(NSInteger, BMDatePickViewMode) {
    /*!
     *  只有年
     */
    BMDatePickViewModeYear = 0,
    /*!
     *  只有年月
     */
    BMDatePickViewModeYearMonth,
    /*!
     *  只有年月日
     */
    BMDatePickViewModeYearMonthDay,
    /*!
     *  只有年月日 时
     */
    BMDatePickViewModeYearMonthDayHour,
    /*!
     *  只有年月日 时分
     */
    BMDatePickViewModeYearMonthDayHourMinute,
    /*!
     *  只有年月日 时分秒
     */
    BMDatePickViewModeYearMonthDayHourMinuteSecond,
};

@interface BMDatePickAlertView : UIView

@property (strong, nonatomic) NSDate *date;

/*!
 *  @brief 创建系统自带的有确定按钮的时间选择弹窗
 */
+ (instancetype)datePickViewWithConfirmForPickerMode:(UIDatePickerMode)pickerMode
                                                date:(NSDate *)date
                                         minimumDate:(NSDate *)minimumDate
                                         maximumDate:(NSDate *)maximumDate
                                        confirmBlock:(ConfirmBlock)confirmBlock;

/*!
 *  @brief 创建自定义的有确定按钮的时间选择弹窗  可选时间范围暂未完成
 */
+ (instancetype)datePickViewWithCustomConfirmForPickerMode:(BMDatePickViewMode)pickerMode
                                                      date:(NSDate *)date
                                               minimumDate:(NSDate *)minimumDate
                                               maximumDate:(NSDate *)maximumDate
                                              confirmBlock:(ConfirmBlock)confirmBlock;
/*!
 *  @brief 创建系统自带的实时交互时间选择弹窗
 */
+ (instancetype)datePickViewWithChangeForPickerMode:(UIDatePickerMode)pickerMode
                                               date:(NSDate *)date
                                        minimumDate:(NSDate *)minimumDate
                                        maximumDate:(NSDate *)maximumDate
                                        changeBlock:(ChangeBlock)changeBlock;

/*!
 *  @brief 创建自定义的实时交互时间选择弹窗 可选时间范围暂未完成
 */
+ (instancetype)datePickViewWirhCustomChangeForPickerMode:(BMDatePickViewMode)pickerMode
                                                     date:(NSDate *)date
                                              minimumDate:(NSDate *)minimumDate
                                              maximumDate:(NSDate *)maximumDate
                                              changeBlock:(ChangeBlock)changeBlock;
- (void)show;

- (void)diss;

@end
