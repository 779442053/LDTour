//
//  BMDatePickView.m
//  BMDatePickViewDemo
//
//  Created by Daredos on 16/6/16.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import "BMDatePickView.h"
#import "BMDateSettingView.h"

#define __sc_w__   [UIScreen mainScreen].bounds.size.width
#define __sc_h__   [UIScreen mainScreen].bounds.size.height
#define __height__ 216.0f

@interface BMDatePickView ()

@property (strong, nonatomic) UIDatePicker      *datePicker;
@property (strong, nonatomic) BMDateSettingView *dateSettingView;
@property (copy, nonatomic) ChangeBlock         changeBlock;
@property (copy, nonatomic) ConfirmBlock        confirmBlock;

@end

@implementation BMDatePickView

#pragma mark -
#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.datePicker];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackgroundClick)]];
    }
    return self;
}

#pragma mark - getters setters

- (BMDateSettingView *)dateSettingView {
    
    if (!_dateSettingView) {
        __weak typeof(self) wself = self;
        _dateSettingView = [BMDateSettingView BMDateSettingViewWithFrame:CGRectMake(0, __sc_h__-__height__-40, __sc_w__, 40) confirmBlock:^{
            __strong typeof(self) self = wself;
            self.confirmBlock ? self.confirmBlock(self.datePicker.date) : nil;
            [self tapBackgroundClick];
        } cancelBlock:^{
            __strong typeof(self) self = wself;
            [self tapBackgroundClick];
        }];
    }
    return _dateSettingView;
}

- (void)setDate:(NSDate *)date {
    
    self.datePicker.date = date;
}

- (NSDate *)date {
    
    return self.datePicker.date;
}
#pragma mark - 系统delegate
#pragma mark - 自定义delegate
#pragma mark - 公有方法
/*! */
+ (void)showChangeDatePickViewPickerMode:(UIDatePickerMode)pickerMode date:(NSDate *)date minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate changeBlock:(ChangeBlock)changeBlock {
    
    UIWindow *win = [[UIApplication sharedApplication] keyWindow];
    BMDatePickView *datePickView = [[BMDatePickView alloc] initWithFrame:win.bounds];
    datePickView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    datePickView.changeBlock = changeBlock;
    datePickView.alpha = 0.0f;
    
    __weak typeof(datePickView) wdatePickView = datePickView;
    [UIView animateWithDuration:0.3 animations:^{
        __strong typeof(datePickView) datePickView = wdatePickView;
        datePickView.alpha = 1.0f;
    }];
    datePickView.datePicker.minimumDate     = minimumDate;
    datePickView.datePicker.maximumDate     = maximumDate;
    datePickView.datePicker.datePickerMode  = pickerMode;
    [datePickView.datePicker addTarget:datePickView action:@selector(datePickChanged) forControlEvents:UIControlEventValueChanged];
    [win addSubview:datePickView];
}

/*! */
+ (void)showConfirmDatePickViewPickerMode:(UIDatePickerMode)pickerMode date:(NSDate *)date minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate confirmBlock:(ConfirmBlock)confirmBlock {
    
    UIWindow *win = [[UIApplication sharedApplication] keyWindow];
    BMDatePickView *datePickView = [[BMDatePickView alloc] initWithFrame:win.bounds];
    datePickView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    datePickView.confirmBlock = confirmBlock;
    [datePickView addSubview:datePickView.dateSettingView];
    datePickView.datePicker.minimumDate     = minimumDate;
    datePickView.datePicker.maximumDate     = maximumDate;
    datePickView.datePicker.datePickerMode  = pickerMode;
    datePickView.alpha = 0.0f;
    __weak typeof(datePickView) wdatePickView = datePickView;
    [UIView animateWithDuration:0.3 animations:^{
        __strong typeof(datePickView) datePickView = wdatePickView;
        datePickView.alpha = 1.0f;
    }];
    [win addSubview:datePickView];
}


/*! 创建自定义的实时交互的时间选择弹窗 */
+ (void)showCustomChangeDatePickViewPickerMode:(BMDatePickViewMode)pickerMode
                                          date:(NSDate *)date
                                   minimumDate:(NSDate *)minimumDate
                                   maximumDate:(NSDate *)maximumDate
                                   changeBlock:(ChangeBlock)changeBlock {
}

/*! 创建自定义的有确定按钮的时间选择弹窗 */
+ (void)showCustomConfirmDatePickViewPickerMode:(BMDatePickViewMode)pickerMode
                                           date:(NSDate *)date
                                    minimumDate:(NSDate *)minimumDate
                                    maximumDate:(NSDate *)maximumDate
                                   confirmBlock:(ConfirmBlock)confirmBlock {
}
#pragma mark - 私有方法

- (UIDatePicker *)datePicker {
    
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, __sc_h__-__height__, __sc_w__, __height__)];
        _datePicker.backgroundColor = [UIColor whiteColor];
    }
    return _datePicker;
}
- (void)datePickChanged {
    
    self.changeBlock ? self.changeBlock(self.datePicker.date) : nil;
}

#pragma mark - 事件响应

- (void)tapBackgroundClick {
    
    __weak typeof(self) wself = self;
    [UIView animateWithDuration:0.3 animations:^{
        __strong typeof(self) self = wself;
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        __strong typeof(self) self = wself;
        [self removeFromSuperview];
    }];
}
@end
