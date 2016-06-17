//
//  BMDatePickView.m
//  BMDatePickViewDemo
//
//  Created by Daredos on 16/6/15.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "BMDatePickView.h"

#define __sc_w__   [UIScreen mainScreen].bounds.size.width
#define __sc_h__   [UIScreen mainScreen].bounds.size.height
#define __height__ 216.0f

@interface BMDatePickView () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) UIPickerView *pickerView;

@end

@implementation BMDatePickView

#pragma mark -

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame date:(NSDate *)date{

    if (self = [super initWithFrame:frame]) {
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackgroundViewClick)]];
        [self addSubview:self.pickerView];
        self.date = date;
    }
    return self;
}

#pragma mark - getters setters

- (NSDate *)date {

    NSInteger year = 0;
    NSInteger mon  = 0;
    NSInteger day  = 0;
    NSInteger h = 0;
    NSInteger m = 0;
    NSInteger s = 0;

    switch (self.datePickerMode) {
            
        case BMDatePickerModeYearMondayHMS:
        {
            s =  [_pickerView selectedRowInComponent:5];
        }
        case BMDatePickerModeYearMondayHM:
        {
            m =  [_pickerView selectedRowInComponent:4];
        }
        case BMDatePickerModeYearMondayH:
        {
            h =  [_pickerView selectedRowInComponent:3];
        }
            
        case BMDatePickerModeYearMonday:
        {
            day  = [_pickerView selectedRowInComponent:2];
        }
        case BMDatePickerModeYearMon:
        {
            mon  = [_pickerView selectedRowInComponent:1];
        }
        case BMDatePickerModeYear:
        {
            year = [_pickerView selectedRowInComponent:0];
        }
        default:
            break;
    }
    
    NSDate *date = [self getDateWithYear:year+1 mon:mon+1 day:day+1 h:h m:m s:s];

    if ([date compare:self.maximumDate] == NSOrderedDescending) {
        self.date = self.maximumDate;
        
    }else if ([date compare:self.minimumDate] == NSOrderedAscending) {
        self.date = self.minimumDate;
    }
    return date;
}

- (void)setDate:(NSDate *)date {

    NSDate *myDate = date ? date : [NSDate date];

    NSCalendar *calendar0 = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar0 components:unitFlags fromDate:myDate];

    NSInteger year   = [comps year];
    NSInteger month  = [comps month];
    NSInteger day    = [comps day];
    NSInteger hour   = [comps hour];
    NSInteger minute = [comps minute];
    NSInteger second = [comps second];

    switch (self.datePickerMode) {
            
        case BMDatePickerModeYearMondayHMS:
        {
            [self.pickerView selectRow:second inComponent:5 animated:YES];
        }
        case BMDatePickerModeYearMondayHM:
        {
            [self.pickerView selectRow:minute inComponent:4 animated:YES];
        }
        case BMDatePickerModeYearMondayH:
        {
            [self.pickerView selectRow:hour   inComponent:3 animated:YES];
        }
            
        case BMDatePickerModeYearMonday:
        {
            [self.pickerView selectRow:day-1    inComponent:2 animated:YES];
        }
        case BMDatePickerModeYearMon:
        {
            [self.pickerView selectRow:month-1  inComponent:1 animated:YES];
        }
        case BMDatePickerModeYear:
        {
            [self.pickerView selectRow:year-1   inComponent:0 animated:YES];
        }
        default:
            break;
    }
    self.changeDateBlock ? self.changeDateBlock(self.date) : nil;
}

- (void)setMinimumDate:(NSDate *)minimumDate {

    _minimumDate = minimumDate;

    if (!minimumDate || !_maximumDate) {
        return;
    }
    if ([minimumDate compare:_maximumDate] == NSOrderedDescending) {
        NSLog(@"设置的时间格式错误~~~");
        _minimumDate = _maximumDate;
    }
}

- (void)setMaximumDate:(NSDate *)maximumDate {

    _maximumDate = maximumDate;

    if (!maximumDate || !_minimumDate) {
        return;
    }
    if ([_minimumDate compare:_maximumDate] == NSOrderedDescending) {
        NSLog(@"设置的时间格式错误~~~");
        _maximumDate = _minimumDate;
    }
}

- (UIPickerView *)pickerView {
    
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, __sc_h__-__height__, __sc_w__, __height__)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
    }
    return _pickerView;
}

#pragma mark - 系统delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {

    switch (self.datePickerMode) {
        case BMDatePickerModeYear:
            return 1;
            break;
        case BMDatePickerModeYearMon:
            return 2;
            break;
        case BMDatePickerModeYearMonday:
            return 3;
            break;
        case BMDatePickerModeYearMondayH:
            return 4;
            break;
        case BMDatePickerModeYearMondayHM:
            return 5;
            break;
        case BMDatePickerModeYearMondayHMS:
            return 6;
            break;
        default:
            break;
    }
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    switch (component) {
        case 0:
            return 2200;
            break;
        case 1:
            return 12;
            break;

        case 2:
        {
            NSInteger year = [pickerView selectedRowInComponent:0];
            NSInteger m = [pickerView selectedRowInComponent:1];
            if (m == 1) {
                return ((year%4==0)&&(year%100!=0))||(year%400==0) ? 29 : 28;
                break;
            }else if (   m ==  1-1
                      || m ==  3-1
                      || m ==  5-1
                      || m ==  7-1
                      || m ==  8-1
                      || m == 10-1
                      || m == 12-1) {
                return 31; // 日
            }
        }
            return 30; // 日
            break;
        case 3:
            return 24;
            break;
        case 4:
            return 60;
            break;
        case 5:
            return 60;
            break;
        default:
            break;
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {

    NSInteger r = row;
    if (component  < 3) {
        r += 1;
    }

    NSMutableString *string = [NSMutableString stringWithFormat:@"%ld",r];
    if (component > 2) {
        string = [NSMutableString stringWithFormat:@"%.2ld",r];
    }

    CGFloat w = (self.datePickerMode+1)*1.0;
    UILabel*label    = [[UILabel alloc]initWithFrame:CGRectMake(component*(__sc_w__/w), 0,__sc_w__/w, 30)];
    label.font       = [UIFont systemFontOfSize:13.0];
    label.adjustsFontSizeToFitWidth = YES;

    label.textAlignment = 1;
    switch (component) {
        case 0:
            [string appendString:@" 年"];
            break;
        case 1:
            [string appendString:@" 月"];
            break;
        case 2:
            [string appendString:@" 日"];
            break;
        case 3:
            [string appendString:@" 时"];
            break;
        case 4:
            [string appendString:@" 分"];
            break;
        case 5:
            [string appendString:@" 秒"];
            break;
        default:
            break;
    }
    label.text          = string;
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    [pickerView reloadAllComponents];

    NSInteger year = 0;
    NSInteger mon  = 0;
    NSInteger day  = 0;
    NSInteger h    = 0;
    NSInteger m    = 0;
    NSInteger s    = 0;
    
    switch (self.datePickerMode) {

        case BMDatePickerModeYearMondayHMS:
        {
            s =  [pickerView selectedRowInComponent:5];
        }
        case BMDatePickerModeYearMondayHM:
        {
            m =  [pickerView selectedRowInComponent:4];
        }
        case BMDatePickerModeYearMondayH:
        {
            h =  [pickerView selectedRowInComponent:3];
        }
        case BMDatePickerModeYearMonday:
        {
            day  = [pickerView selectedRowInComponent:2];
        }
        case BMDatePickerModeYearMon:
        {
            mon  = [pickerView selectedRowInComponent:1];
        }
        case BMDatePickerModeYear:
        {
            year = [pickerView selectedRowInComponent:0];
        }
        default:
            break;
    }

    NSDate *date = [self getDateWithYear:year+1 mon:mon+1 day:day+1 h:h m:m s:s];

    if ([date compare:self.maximumDate] == NSOrderedDescending) {

        self.date = self.maximumDate;
        
    }else if ([date compare:self.minimumDate] == NSOrderedAscending) {
        
        self.date = self.minimumDate;
    }
    self.changeDateBlock ? self.changeDateBlock(date) : nil;
}

#pragma mark - 自定义delegate

#pragma mark - 公有方法

+ (instancetype)datePickViewWithDate:(NSDate *)date changeDateBlock:(BMChangeDateBlock)changeDateBlock {
    
    UIWindow *win = [[UIApplication sharedApplication] keyWindow];
    BMDatePickView *datePickView = [[BMDatePickView alloc] initWithFrame:win.bounds date:date];
    datePickView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    datePickView.changeDateBlock = changeDateBlock;
    return datePickView;
}

- (void)show {
    UIWindow *win = [[UIApplication sharedApplication] keyWindow];
    [self.pickerView reloadAllComponents];
    [win addSubview:self];
    self.date = self.date;
    self.changeDateBlock ? self.changeDateBlock(self.date) : nil;
    self.alpha = 0.0f;
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1.0f;
    }];
}

#pragma mark - 私有方法

- (NSDate *)getDateWithYear:(NSInteger)year mon:(NSInteger)mon day:(NSInteger)day h:(NSInteger)h m:(NSInteger)m s:(NSInteger)s {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    NSString *str = [NSString stringWithFormat:@"%.4ld-%.2ld-%.2ld--%.2ld:%.2ld:%.2ld",year,mon,day,h,m,s];

    [dateFormatter setDateFormat:@"yyyy-MM-dd--HH:mm:ss"];

    NSDate *date = [dateFormatter dateFromString:str];

    return date;
}

- (NSString *)getStringWithDate:(NSDate *)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd  HH:mm:ss"];
    NSString *string = [dateFormatter stringFromDate:date];
    return string;
}

#pragma mark - 事件响应

- (void)tapBackgroundViewClick {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
