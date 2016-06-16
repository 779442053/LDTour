//
//  BMDatePickView.h
//  BMDatePickViewDemo
//
//  Created by Daredos on 16/6/16.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import <UIKit/UIKit.h>

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
    BMDatePickViewModeYearMonthDayHourSecond,
};

typedef void(^ChangeBlock)(NSDate *date);
typedef void(^ConfirmBlock)(NSDate *date);

@interface BMDatePickView : UIView

@property (strong, nonatomic) NSDate *date;


/*! 创建系统自带的的实时交互的时间选择弹窗 */
+ (void)showChangeDatePickViewPickerMode:(UIDatePickerMode)pickerMode
                                    date:(NSDate *)date
                             minimumDate:(NSDate *)minimumDate
                             maximumDate:(NSDate *)maximumDate
                             changeBlock:(ChangeBlock)changeBlock;

/*! 创建系统自带的实时交互的时间选择弹窗 */
+ (void)showConfirmDatePickViewPickerMode:(UIDatePickerMode)pickerMode
                                     date:(NSDate *)date
                              minimumDate:(NSDate *)minimumDate
                              maximumDate:(NSDate *)maximumDate
                             confirmBlock:(ConfirmBlock)confirmBlock;

/*! 创建自定义的实时交互的时间选择弹窗 */
+ (void)showCustomChangeDatePickViewPickerMode:(BMDatePickViewMode)pickerMode
                                          date:(NSDate *)date
                                   minimumDate:(NSDate *)minimumDate
                                   maximumDate:(NSDate *)maximumDate
                                   changeBlock:(ChangeBlock)changeBlock __deprecated_msg("方法正在完善中");

/*! 创建自定义的有确定按钮的时间选择弹窗 */
+ (void)showCustomConfirmDatePickViewPickerMode:(BMDatePickViewMode)pickerMode
                                           date:(NSDate *)date
                                    minimumDate:(NSDate *)minimumDate
                                    maximumDate:(NSDate *)maximumDate
                                   confirmBlock:(ConfirmBlock)confirmBlock __deprecated_msg("方法正在完善中");
@end




