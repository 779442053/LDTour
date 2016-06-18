//
//  LDCitPersonVC.m
//  LDTour
//
//  Created by Daredos on 16/6/4.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDCitPersonVC.h"
#import "BMDatePickAlertView.h"

@interface LDCitPersonVC ()


@end

@implementation LDCitPersonVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)systemDatePickForHaveConfirm {

    BMDatePickAlertView *s = [BMDatePickAlertView datePickViewWithConfirmForPickerMode:arc4random()%4 date:nil minimumDate:nil maximumDate:nil confirmBlock:^(BMDatePickAlertView *datePickView, NSDate *date) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd--HH:mm:ss"];
        NSLog(@"时间： %@",[dateFormatter stringFromDate:date]);
        [datePickView diss];
    }];
    [s show];
}

- (IBAction)systemDatePickForChanged {
    
    BMDatePickAlertView *s = [BMDatePickAlertView datePickViewWithChangeForPickerMode:arc4random()%4 date:nil minimumDate:nil maximumDate:nil changeBlock:^(BMDatePickAlertView *datePickView, NSDate *date) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd--HH:mm:ss"];
        NSLog(@"时间： %@",[dateFormatter stringFromDate:date]);
    }];
    [s show];
}


- (IBAction)selfDatePickForHaveConfirm {
    
    BMDatePickAlertView *s = [BMDatePickAlertView datePickViewWithCustomConfirmForPickerMode:arc4random()%6 date:nil minimumDate:nil maximumDate:nil confirmBlock:^(BMDatePickAlertView *datePickView, NSDate *date) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd--HH:mm:ss"];
        NSLog(@"时间： %@",[dateFormatter stringFromDate:date]);
        [datePickView diss];
    }];
    [s show];
}

- (IBAction)selfDatePickForChanged {
    
    BMDatePickAlertView *s = [BMDatePickAlertView datePickViewWirhCustomChangeForPickerMode:arc4random()%6 date:nil minimumDate:nil maximumDate:nil changeBlock:^(BMDatePickAlertView *datePickView, NSDate *date) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd--HH:mm:ss"];
        NSLog(@"时间： %@",[dateFormatter stringFromDate:date]);
    }];
    [s show];
}


@end
